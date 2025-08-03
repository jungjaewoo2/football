package football.service;

import football.entity.Person;
import football.repository.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class PersonService {
    @Autowired
    private PersonRepository personRepository;

    public List<Person> findAll() {
        return personRepository.findAll();
    }

    public Optional<Person> findById(Integer uid) {
        return personRepository.findById(uid);
    }

    public Person save(Person person) {
        // 등록/수정 시간 자동 설정
        if (person.getCreatedAt() == null) {
            person.setCreatedAt(LocalDateTime.now());
        }
        person.setUpdatedAt(LocalDateTime.now());
        
        return personRepository.save(person);
    }

    public void deleteById(Integer uid) {
        personRepository.deleteById(uid);
    }

    public Optional<Person> findFirst() {
        List<Person> persons = personRepository.findAll();
        return persons.isEmpty() ? Optional.empty() : Optional.of(persons.get(0));
    }
} 