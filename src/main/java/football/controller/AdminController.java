package football.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Controller
public class AdminController {

    @Autowired
    private DataSource dataSource;

    // 관리자 로그인 페이지 표시
    @GetMapping("/admin/login")
    public String adminLoginPage() {
        return "admin/login";
    }

    // 관리자 로그인 처리
    @PostMapping("/admin/adminLogin")
    public String adminLogin(@RequestParam String id,
                           @RequestParam String passwd,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {

        String sql = "SELECT * FROM admin WHERE id = ? AND passwd = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id);
            pstmt.setString(2, passwd);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // 로그인 성공
                    session.setAttribute("adminId", id);
                    session.setAttribute("adminUid", rs.getInt("uid"));
                    // 로그인 성공 시 비밀번호 변경 화면으로 이동
                    return "redirect:/admin/changePassword";
                } else {
                    // 로그인 실패
                    redirectAttributes.addAttribute("error", "true");
                    return "redirect:/admin/login";
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            redirectAttributes.addAttribute("error", "true");
            return "redirect:/admin/login";
        }
    }

    // 관리자 로그아웃
    @GetMapping("/admin/logout")
    public String adminLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }

    // 관리자 대시보드 (로그인 후 접근)
    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session) {
        // 세션에서 관리자 정보 확인
        if (session.getAttribute("adminId") == null) {
            return "redirect:/admin/login";
        }
        return "admin/dashboard"; // 대시보드 페이지로 이동
    }

    // 비밀번호 변경 화면
    @GetMapping("/admin/changePassword")
    public String changePasswordPage(HttpSession session) {
        if (session.getAttribute("adminId") == null) {
            return "redirect:/admin/login";
        }
        return "admin/changePassword";
    }

    // 비밀번호 변경 처리
    @PostMapping("/admin/changePassword")
    public String changePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        String adminId = (String) session.getAttribute("adminId");
        if (adminId == null) {
            return "redirect:/admin/login";
        }
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "새 비밀번호가 일치하지 않습니다.");
            return "redirect:/admin/changePassword";
        }

        try (Connection conn = dataSource.getConnection()) {
            // 현재 비밀번호 확인
            String sql = "SELECT * FROM admin WHERE id = ? AND passwd = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, adminId);
                pstmt.setString(2, currentPassword);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (!rs.next()) {
                        redirectAttributes.addFlashAttribute("error", "현재 비밀번호가 올바르지 않습니다.");
                        return "redirect:/admin/changePassword";
                    }
                }
            }

            // 비밀번호 변경
            String updateSql = "UPDATE admin SET passwd = ? WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                pstmt.setString(1, newPassword);
                pstmt.setString(2, adminId);
                int updated = pstmt.executeUpdate();
                if (updated > 0) {
                    redirectAttributes.addFlashAttribute("success", "비밀번호가 성공적으로 변경되었습니다.");
                    return "redirect:/admin/dashboard";
                } else {
                    redirectAttributes.addFlashAttribute("error", "비밀번호 변경에 실패했습니다.");
                    return "redirect:/admin/changePassword";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "오류가 발생했습니다.");
            return "redirect:/admin/changePassword";
        }
    }
} 