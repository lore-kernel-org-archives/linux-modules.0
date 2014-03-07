MIME-Version: 1.0
In-Reply-To: <5316F334020000460004B5AA@gwia2.rz.hs-offenburg.de>
References: <5316F334020000460004B5AA@gwia2.rz.hs-offenburg.de>
Date: Fri, 7 Mar 2014 01:08:36 -0300
Message-ID: <CAKi4VAJ=VjGnbzbkL99sx7AEouNrXxdErHmO1VJmVL28_n1fDA@mail.gmail.com>
Subject: Re: Linux kernel module is not running anymore when switching from
 mdev to udev
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Frank Ihle <frank.ihle@hs-offenburg.de>
Cc: linux-modules <linux-modules@vger.kernel.org>, buildroot <buildroot@busybox.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Frank,

On Wed, Mar 5, 2014 at 5:49 AM, Frank Ihle <frank.ihle@hs-offenburg.de> wro=
te:
> Hi everyone,
>
> there is this problem, that I searched the Internet
> for its solution but without success. Here's what it's about, I hope
> someone can give me a hint:
>
>
>
>         I'm using Buildroot 2013.10 to generate my Linux 2.6.39 Images, w=
ith the following Kernel  module:
>
>
>
>   void GPIO_LED(void) {
>
>   printk(" GPIO: set PC8: '0');
>
>   at91_set_gpio_value(AT91_PIN_PC8, 1);
>
>
>   }
>
>
>   int init_module(void) {
>
>   GPIO_LED();   return 0;
>
>
>   }
>
>
>   MODULE_LICENSE("GPL");
>
>
>
> When using it with mdev device management. everything works just
> fine. But using it with a udev device management, while executing insmod

I don't see how udev could be related to your problem. Maybe just how
the dependencies were chosen...


>
>
>
>   insmod /usr/modules/measurement_gpio.ko
>
>
>
> the following message appeared:
>
>
>
>   insmod: can't insert '/usr/modules/measurement_gpio.ko': invalid
>   module format
>
>
>
> Every setting stayed the same (especially the kernel version) but the
>  device management changes during this test, so actually the module
> should be fine. Building the kernel to be able for loading modules for
> multiple versions didn't solve it, neither the option "force module
> loading"
>
>
> The way I build my module is:
>
>
> with Buildroot I'm generating an Image, on the way a Linux 2.6.39 is inst=
alled.Afterwards I'm compiling the kernel module with the path to the Linux=
 2.6.39, that Buildroot has downloaded.When the module is created I'm putti=
ng it into a fs-overlay directory, so it will be included into the image on=
 next build.I hit another "make" on Buildroot and i got everything together=
 and a bootable image.
>
>
> I change nothing, that's why it confuses me even more
>
>
> How can this be and how to solve it?

I successfully built an image with buildroot using systemd/udev/kmod
some days ago. And inserting modules work fine. If it was a more
recent kernel I'd say it's because you enabled module signature and
your out-of-tree module isn't signed.  But it doesn't look like this.

CC'ing buildroot's ML to see if they have a clue.

>
> Kind Regards,
> Frank
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20

Lucas De Marchi
