## Contributing
At this point it's still very early in the process. I have a small to do list setup in the [wiki](https://github.com/steveno/balistica/wiki/To-Do); please take
any of the tasks you want, but please also file a ticket so I know you're working on it.

As always please file any and all [bugs](https://github.com/steveno/balistica/issues?state=open).

## Coding Style
I have my own coding style
and I'd prefer to try to mimic it as much as possible. Here the highlights:
 1. Always use tabs
 2. No trailing spaces 
 3. Always use UNIX line endings

SAMPLE **if .. then** statement
``` Vala
if (test == 1) {
 return 1;
} else {
 return 0;
}
```

SAMPLE **spacing**
```Vala
if (a == 2 && b == 1)

x = 2 + y;

x = i[10];

a = (int) b;
```

A good place to start if that isn't enough for you is to just use the coding style from [FreeBSD](http://www.freebsd.org/cgi/man.cgi?query=style&sektion=9).

Finally, yes, I am aware that a lot of the code at this point doesn't meet my own defined
coding style. I am actively trying to update it as I go.
