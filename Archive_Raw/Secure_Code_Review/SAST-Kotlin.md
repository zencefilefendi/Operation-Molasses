

# Kotlin Backend Components and Security Testing

| **Component** | **Purpose** | **Tester’s Focus** | **Common Risks** |
|---------------|-------------|--------------------|------------------|
| **Controller** | Handles HTTP requests, maps endpoints, returns responses | Validate inputs, enforce authentication/authorization, check response encoding | XSS if raw data returned, broken access control, insecure direct object references |
| **Service** | Contains business logic (rules, workflows) | Verify role-based access, logic correctness, edge cases, business rule enforcement | Missing authorization checks, logic bypass, privilege escalation |
| **Repository** | Data access layer, interacts with DB | Test for SQL injection, unsafe queries, proper use of ORM, secure data handling | SQL injection, insecure storage of malicious payloads, improper query building |
| **Model** | Defines data structures (entities, DTOs) | Validate serialization/deserialization, enforce constraints, check field validation | Unsafe data propagation, weak validation, overexposed sensitive fields |
| **Config** | Application configuration (security, DB, logging) | Check security headers, DB credentials, logging practices, environment separation | Hardcoded secrets, insecure configs, missing HTTPS enforcement |
| **Middleware** | Intercepts requests/responses (logging, auth, error handling) | Ensure consistent authentication, logging, error handling | Sensitive data leaks, weak auth enforcement, missing rate limiting |
| **Utils** | Helper functions (date, string, etc.) | Check safe handling of input/output, encoding/decoding | Unsafe string handling, weak sanitization, insecure crypto usage |
| **Tests** | Unit/integration tests | Review coverage of security cases, edge cases, negative scenarios | Missing tests for edge cases, weak validation coverage, false sense of security |

---

# Functions / Methods Cheat Sheet

| **Function/Method** | **Purpose** | **Tester’s Focus** | **Risk** |
|----------------------|-------------|--------------------|----------|
| **getUser()** | Fetch user data | Ensure sensitive info not exposed (e.g., passwords, tokens) | Data leakage |
| **findUserById()** | Retrieve user by ID | Check authorization (can one user access another’s data?) | IDOR (Insecure Direct Object Reference) |
| **respondText()** | Send plain text response | Verify output encoding, escaping of HTML | XSS |
| **saveUser()** | Create new user | Validate input, enforce constraints | Injection attacks, weak validation |
| **updateUser()** | Update user record | Check authorization, enforce role-based rules | Privilege escalation |
| **deleteUser()** | Delete user | Ensure proper permissions, audit logging | Unauthorized deletion |
| **login()** | Authenticate user | Test brute force protection, error messages, secure password handling | Weak authentication, information leakage |
| **generateToken()** | Issue JWT/session | Check expiration, signature validation, secure storage | Token replay, weak signing, insecure storage |
| **validateInput()** | Sanitize/validate input | Test coverage of sanitization (XSS, SQL injection, path traversal) | Missed edge cases |
| **handleException()** | Centralized error handling | Check error messages, ensure no sensitive info leaks | Stack trace exposure, sensitive data leaks |

---

# Libraries Cheat Sheet

| **Library** | **Purpose** | **Tester’s Focus** | **Risk** |
|-------------|-------------|--------------------|----------|
| **Ktor / Spring Boot** | Web framework | Check routing, middleware defaults, error handling | Misconfigured endpoints, insecure defaults |
| **Exposed / Hibernate** | Database ORM | Ensure parameterized queries, safe query building | SQL injection, unsafe native queries |
| **Jackson / Kotlinx Serialization** | JSON handling | Test safe serialization, avoid exposing sensitive fields | Unsafe data injection, overexposed fields |
| **Auth0/JWT** | Token handling | Validate token security, expiration, signature | Weak token validation, replay attacks |
| **Logback/SLF4J** | Logging | Check sensitive data logging, log rotation | Credential leaks, log injection |
| **JUnit/Mockito** | Testing | Ensure security tests exist, negative cases covered | Missing coverage, false positives |
| **Koin/Dagger** | Dependency injection | Check secure DI config, avoid insecure singletons | Misconfigured injection, insecure defaults |

---

# Interfaces Cheat Sheet

| **Interface** | **Purpose** | **Tester’s Focus** | **Risk** |
|---------------|-------------|--------------------|----------|
| **UserRepository** | Abstract DB operations | Ensure secure DB calls, parameterized queries | SQL injection |
| **AuthService** | Authentication contract | Verify consistent use across endpoints | Weak authentication enforcement |
| **PaymentGateway** | External integration | Check API key security, HTTPS usage | Insecure external calls, key leakage |
| **EmailService** | Send emails | Test for injection, safe content handling | Email header injection, spam relay |
| **CacheProvider** | Cache data | Check sensitive data handling, expiration policies | Token leakage, stale data exposure |

---


# Java vs Kotlin Backend Components 

| **Aspect / Component** | **Java (Annotation‑Driven)** | **Kotlin (DSL‑Driven)** |
|-------------------------|------------------------------|--------------------------|
| **Common Frameworks** | **Spring Boot** → Full‑stack web framework, annotation‑driven, enterprise‑ready. <br> **Spring MVC** → Handles routing/controllers (`@RestController`, `@GetMapping`). <br> **Spring Security** → Authentication, authorization, CSRF protection (`@EnableWebSecurity`, `@PreAuthorize`). <br> **Hibernate / JPA** → ORM for DB mapping (`@Entity`, `@Repository`). <br> **Micronaut / Quarkus** → Modern alternatives to Spring, faster startup, cloud‑native. | **Ktor** → Lightweight Kotlin‑native web framework, DSL routing, coroutine‑friendly. <br> **Exposed** → SQL DSL/ORM for Kotlin, type‑safe queries. <br> **Koin** → Dependency injection with Kotlin DSL (`module { single { UserService() } }`). <br> **Arrow** → Functional programming library (immutability, type safety). <br> **Micronaut (Kotlin support)** → Alternative to Ktor for microservices. |
| **Controller / Routing** | `@RestController` → Marks REST controller. <br> `@GetMapping("/users")` → Maps GET requests. <br> `@PostMapping("/users")` → Maps POST requests. <br> `@RequestMapping("/api")` → Base path for endpoints. | `routing { get("/users") { call.respondText("All users") } post("/users") { call.respond(HttpStatusCode.Created) } }` |
| **Dependency Injection** | `@Autowired` → Injects a bean. <br> `@Component` → Marks a Spring bean. <br> `@Service` → Marks business logic class. <br> `@Repository` → Marks DB access class. | `val myModule = module { single { UserService() } single { UserRepository(get()) } }` <br> `startKoin { modules(myModule) }` |
| **Models / Entities** | `@Entity` → Marks DB entity. <br> `@Table(name="users")` → Maps to DB table. <br> `@Id` → Primary key. <br> `@Column(nullable=false)` → Column constraints. | `@Serializable data class User(val id: Int, val name: String)` <br> Exposed DSL: `object Users : Table() { val id = integer("id").autoIncrement() val name = varchar("name", 255) }` |
| **Repository / DB Access** | `interface UserRepository extends JpaRepository<User, Long>` → Auto CRUD. <br> `@Query("SELECT u FROM User u WHERE u.name = ?1")` → Custom query. | `Users.select { Users.name eq "Alice" }.map { it[Users.id] }` <br> `transaction { User.new { name = "Alice" } }` |
| **Configuration** | `@Configuration` → Marks config class. <br> `@Bean` → Defines a bean. <br> `application.properties` / `application.yml` → External configs. | `application.conf` (HOCON). <br> Ktor DSL: `install(ContentNegotiation) { json() }` |
| **Middleware / Filters** | `OncePerRequestFilter` → Custom filter. <br> `HandlerInterceptor` → Pre/post request handling. | Ktor plugins: `install(Authentication) { jwt { ... } }` <br> `install(CallLogging)` |
| **Error Handling** | `@ControllerAdvice` → Global error handler. <br> `@ExceptionHandler(Exception.class)` → Handle specific exceptions. | `install(StatusPages) { exception<Throwable> { call.respond(HttpStatusCode.InternalServerError) } }` |
| **Serialization** | Jackson: `@JsonProperty("username")` → Maps JSON field. <br> `@JsonIgnore` → Excludes field. | kotlinx.serialization: `@Serializable data class User(val id: Int, val name: String)` |
| **Security** | Spring Security: `@EnableWebSecurity` → Enables security config. <br> `@PreAuthorize("hasRole('ADMIN')")` → Role-based access. | Ktor Authentication plugin: `install(Authentication) { jwt { realm = "ktor" validate { ... } } }` |
| **Logging** | SLF4J + Logback: `logger.info("User created")` | Ktor CallLogging: `install(CallLogging) { level = Level.INFO }` |
| **Async Handling** | Java: `CompletableFuture.supplyAsync(...)` <br> Spring WebFlux: `Mono<User>` / `Flux<User>` | Kotlin coroutines: `suspend fun getUser(): User` <br> `launch { ... }` |
| **API Documentation** | SpringDoc OpenAPI: `@Operation(summary="Get users")` | Ktor OpenAPI plugin: `install(OpenAPI) { ... }` |
| **Testing** | JUnit: `@Test void testUser() { ... }` <br> Mockito: `@Mock`, `@InjectMocks` | JUnit + MockK: `@Test fun testUser() { coEvery { repo.findUser() } returns User(1,"Alice") }` |


# Security Testing Checklist per Layer

**Client Request → Controller → Service → Repository → Database → Response**

- **Client Request**: Test malformed inputs, fuzzing, injection attempts.  
- **Controller**: Validate inputs, enforce authentication/authorization, check response encoding, test error handling.  
- **Service**: Verify business rules, role-based access, edge cases, data validation.  
- **Repository**: Test for SQL injection, parameterized queries, secure data handling, audit logging.  
- **Database**: Check encryption of sensitive fields, least privilege access, stored payloads, backups.  
- **Response**: Confirm output encoding, generic error messages, no sensitive data exposure, secure headers.  

