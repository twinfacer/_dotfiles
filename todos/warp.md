### warp

Warp any directory on local (or remote) host. Simple. Observe.

```shell
# Doing typical stuff on my local work machine.
[:john:~]$ cd /var/log/some-service
[:john:/var/log/some-service]$ cat log.txt | less
# Suddenly messenger rings out - some one says that one of the client site is down! No problem, lets warp in!
$ warp vip-client
==> warping to: support@123.123.123.456
==> transferring env: [success]
==> ssh warping: done
[vip-client:support:/home/support] $ rails c
# Solving bug. Uf, it was tough. Lets go back.
[vip-client:support:/home/support] $ warp back
==> warp back: john@devmachine
[:john:/var/log/some-service]$
[vip-client:support:/var/www/app] $ warp back
==> warping to: <workstation>
[user:~] $

```


warp points (~/.warprc)
```
[points]
pr1 = ~/proj/project1
dot = ~/.dotfiles
conf = /etc
@vip-client = support@175.112.004.012
@vip-client:app = /var/www/app
