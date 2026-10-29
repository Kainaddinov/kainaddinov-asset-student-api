package com.kainaddinov.asset.studentapi;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/api/students")
public class StudentController {

    private final StudentRepository repository;

    public StudentController(StudentRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    public List<Student> getAll() {
        return repository.findAll();
    }

    @GetMapping("/{id}")
    public Student getById(@PathVariable Long id) {
        return repository.findById(id)
                .orElseThrow(() -> notFound(id));
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Student create(@RequestBody Student student) {
        student.setId(null);
        return repository.save(student);
    }

    @PutMapping("/{id}")
    public Student update(@PathVariable Long id, @RequestBody Student data) {
        Student student = repository.findById(id)
                .orElseThrow(() -> notFound(id));

        student.setFirstName(data.getFirstName());
        student.setLastName(data.getLastName());
        student.setEmail(data.getEmail());
        student.setGroupName(data.getGroupName());
        student.setStudentIdentifier(data.getStudentIdentifier());

        return repository.save(student);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable Long id) {
        if (!repository.existsById(id)) {
            throw notFound(id);
        }
        repository.deleteById(id);
    }

    private ResponseStatusException notFound(Long id) {
        return new ResponseStatusException(
                HttpStatus.NOT_FOUND,
                "Student with id " + id + " not found"
        );
    }
}
