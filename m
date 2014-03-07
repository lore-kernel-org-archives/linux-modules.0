Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Fri, 7 Mar 2014 09:15:34 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Frank Ihle <frank.ihle@hs-offenburg.de>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>, buildroot
 <buildroot@busybox.net>, linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [Buildroot] Linux kernel module is not running anymore when
 switching from mdev to udev
Message-ID: <20140307091534.49f49b02@skate>
In-Reply-To: <CAKi4VAJ=VjGnbzbkL99sx7AEouNrXxdErHmO1VJmVL28_n1fDA@mail.gmail.com>
References: <5316F334020000460004B5AA@gwia2.rz.hs-offenburg.de>
	<CAKi4VAJ=VjGnbzbkL99sx7AEouNrXxdErHmO1VJmVL28_n1fDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-modules.vger.kernel.org>

Frank,

On Fri, 7 Mar 2014 01:08:36 -0300, Lucas De Marchi wrote:

> > there is this problem, that I searched the Internet
> > for its solution but without success. Here's what it's about, I hope
> > someone can give me a hint:
> >
> >
> >
> >         I'm using Buildroot 2013.10 to generate my Linux 2.6.39 Images, with the following Kernel  module:
> >
> >
> >
> >   void GPIO_LED(void) {
> >
> >   printk(" GPIO: set PC8: '0');
> >
> >   at91_set_gpio_value(AT91_PIN_PC8, 1);
> >
> >
> >   }
> >
> >
> >   int init_module(void) {
> >
> >   GPIO_LED();   return 0;
> >
> >
> >   }
> >
> >
> >   MODULE_LICENSE("GPL");
> >
> >
> >
> > When using it with mdev device management. everything works just
> > fine. But using it with a udev device management, while executing insmod
> 
> I don't see how udev could be related to your problem. Maybe just how
> the dependencies were chosen...

I agree: the kernel module shown by Frank only toggle a GPIO, and does
not expose any device in /dev or anything that would involve udev or
mdev.

> > the following message appeared:
> >
> >   insmod: can't insert '/usr/modules/measurement_gpio.ko': invalid
> >   module format

Are you sure you have built your module correctly, against the right
version of the kernel headers that match the kernel you're running?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
