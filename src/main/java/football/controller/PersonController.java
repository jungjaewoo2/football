package football.controller;

import football.entity.Person;
import football.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Optional;

@Controller
@RequestMapping("/admin/person")
public class PersonController {
    private static final Logger logger = LoggerFactory.getLogger(PersonController.class);
    
    @Autowired
    private PersonService personService;

    @GetMapping("")
    public String view(Model model) {
        try {
            logger.info("개인정보 관리 페이지 요청");
            Optional<Person> person = personService.findFirst();
            if (person.isPresent()) {
                model.addAttribute("person", person.get());
            } else {
                model.addAttribute("person", new Person());
            }
            return "admin/person/view";
        } catch (Exception e) {
            logger.error("개인정보 관리 페이지 로드 중 오류 발생", e);
            model.addAttribute("error", "페이지를 불러오는 중 오류가 발생했습니다.");
            return "admin/person/view";
        }
    }

    @GetMapping("/edit")
    public String editForm(Model model) {
        try {
            logger.info("개인정보 수정 페이지 요청");
            Optional<Person> person = personService.findFirst();
            if (person.isPresent()) {
                model.addAttribute("person", person.get());
            } else {
                model.addAttribute("person", new Person());
            }
            return "admin/person/edit";
        } catch (Exception e) {
            logger.error("개인정보 수정 페이지 로드 중 오류 발생", e);
            model.addAttribute("error", "페이지를 불러오는 중 오류가 발생했습니다.");
            return "admin/person/edit";
        }
    }

    @PostMapping("/edit")
    public String edit(@RequestParam("content") String content, Model model) {
        try {
            logger.info("개인정보 수정 요청 시작");
            
            Optional<Person> existingPerson = personService.findFirst();
            Person person;
            
            if (existingPerson.isPresent()) {
                person = existingPerson.get();
                person.setContent(content);
            } else {
                person = new Person(content);
            }
            
            personService.save(person);
            logger.info("개인정보 수정 완료");
            model.addAttribute("success", "개인정보가 성공적으로 수정되었습니다.");
            model.addAttribute("person", person);
            return "admin/person/view";
        } catch (Exception e) {
            logger.error("개인정보 수정 중 오류 발생", e);
            model.addAttribute("error", "개인정보 수정 중 오류가 발생했습니다.");
            return "admin/person/edit";
        }
    }
} 