## Contributing
I have a small to do list setup in the [wiki](https://github.com/steveno/balistica/wiki/To-Do); please take
any of the tasks you want, but please also file a ticket so I know you're working on it.

As always please file any and all [bugs](https://github.com/steveno/balistica/issues?state=open).

## Uncrustify
The code is formated through uncrustify. It's not perfect but it works 90% of the time so I use it.
In order to make it simple for me I use the script found [here](https://gist.github.com/steveno/32f098abb6d08e34da29ba182a93705e).
You only need to make sure you're one directory above balistica when you do.

## Seeing debug messages
If you haven't noticed already the code is sprinkled with debug statements. In order you to see 
the messages you'll need to run the application like so:
```
G_MESSAGES_DEBUG=all ./balistica > output.txt
```
The time to run a drag calculation will slow down considerably. Also note that text file is going
to get quite large rather quickly so prepared to dig for whatever it is you're looking for.
