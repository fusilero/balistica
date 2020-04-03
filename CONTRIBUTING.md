## Contributing
If you would like to contribute, check the github issues. Please take any of the tasks you want, 
but please also comment on the issue so I know you're working on it.

As always please file any and all [bugs](https://github.com/fusliero/balistica/issues?state=open).

## Uncrustify
The code is formated through uncrustify. It's not perfect but it works 90% of the time so I use it.

## Seeing debug messages
If you haven't noticed already LibBalistica is sprinkled with debug statements. In order you to see 
the messages you'll need to run the application like so:
```
G_MESSAGES_DEBUG=all ./balistica > output.txt
```
The time to run a drag calculation will slow down considerably. Also note that text file is going
to get quite large rather quickly so prepared to dig for whatever it is you're looking for.
