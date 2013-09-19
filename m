MIME-Version: 1.0
In-Reply-To: <1379602136-3937-1-git-send-email-dreisner@archlinux.org>
References: <1379602136-3937-1-git-send-email-dreisner@archlinux.org>
Date: Thu, 19 Sep 2013 10:44:35 -0500
Message-ID: <CAKi4VAKe5SRYxG6sh1LGE4VT4bCh-ajWQuB58=PNVvwv9JR+vg@mail.gmail.com>
Subject: Re: [PATCH] static-nodes: add shell consumable format
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Dave Reisner <dreisner@archlinux.org>
Cc: linux-modules <linux-modules@vger.kernel.org>, Harald Hoyer <harald.hoyer@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Sep 19, 2013 at 9:48 AM, Dave Reisner <dreisner@archlinux.org> wrote:
> This adds an additional format to kmod static-nodes, which writes
> output as shell commands, e.g.:
>
>   mknod '/dev/btrfs-control' c 10 234
>   mknod '/dev/loop-control' c 10 237
>   mkdir -m 755 -p '/dev/net'
>   mknod '/dev/net/tun' c 10 200
>
> Consumers of this format can simply pipe the output to a shell,
> creating the necessary static nodes. This could be useful for an
> initramfs which doesn't have systemd-tmpfiles but which still relies on
> static node creation which recent udev will no longer handle.

I got a similar request from Harald (CC'ed), but instead to create the
nodes ourselves.

The way you did fits better with the current purpose of the
static-nodes, but I'm ok with creating the nodes ourselves, too.


Harald, would this work for you as well?

Lucas De Marchi
