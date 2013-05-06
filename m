MIME-Version: 1.0
In-Reply-To: <1367765701.2383.11.camel@neuromancer.tessier-ashpool>
References: <1367765701.2383.11.camel@neuromancer.tessier-ashpool>
Date: Mon, 6 May 2013 12:59:27 -0300
Message-ID: <CAKi4VAJd5AGRfJ2otK5P_RJ2JFdiPDm8K=iHk5CLih4e=zuovg@mail.gmail.com>
Subject: Re: depmod difference between module-init-tools and kmod
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Stefan Achatz <stefan_achatz@web.de>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Stefan,

On Sun, May 5, 2013 at 11:55 AM, Stefan Achatz <stefan_achatz@web.de> wrote:
> Hello,
>
> I'm writing kernel modules for usb peripheries that are in mainline kernel and
> also available as external compileable package[1].
>
> The external modules have the newest code before it gets into the next kernel,
> also backported for older kernels. To distinguish between outdated kernel
> included and newer external modules they have different names. The device
> specific kernel internal modules are called hid-roccat-* whereas the external
> ones are called just *. This way a blacklist can prohibit loading the internal
> modules when the external are installed.

Since depmod (both from kmod and module-init-tools) doesn't know
anything about blacklists it can't rely on this existing so to not
creating "invalid" indexes.

Taking a look on our current implementation, it looks like we fail on
warning about duplicate symbols while inserting them on hash table to
calculate the dependencies. I guess this only worked for you on
module-init-tools by luck since its  hash table allows duplicate
entries, but then on lookup you will get the first one, depending on
the order in which they were inserted. IMO it seems a very weak
guarantee on which module will get.


>
> Nevertheless, having both, internal and external, modules installed leads to
> double symbols. depmod from module-init-tools has no problem with that (some
> of the last versions tested), where the variant from kmod has its problem (v5
> up to v12 tested). I observed this using Fedora 18, which seems to be the first
> distro that uses kmods depmod.
>
> Some outputs of both depmods for comparison are further down this text.
>
> My question: Should this behaviour be fixed in kmods depmod, or is there a
> intended, perhaps more intelligent, way for me to do what I intend?

I'd propose you check if the following scheme fits your needs:

1) change the external modules to have the same names as the internal ones
2) install a file under /usr/lib/depmod.d/module-name.conf containing
an "override" line - see depmod.d(5)
or
2a) Use a .conf file with "search" keyword, ensuring its priority is
higher than the standard ones

>
> Thanks and have a nice day
> Stefan
>
> **** depmod from module-init-tools
>
> $ grep roccat /lib/modules/$(uname -r)/modules.dep
>
> kernel/drivers/hid/hid-roccat.ko:
> kernel/drivers/hid/hid-roccat-common.ko:
> kernel/drivers/hid/hid-roccat-arvo.ko: extra/roccat-common.ko extra/roccat.ko
> kernel/drivers/hid/hid-roccat-isku.ko: extra/roccat-common.ko extra/roccat.ko
> kernel/drivers/hid/hid-roccat-kone.ko: extra/roccat.ko
> kernel/drivers/hid/hid-roccat-koneplus.ko: extra/roccat-common.ko extra/roccat.ko
> kernel/drivers/hid/hid-roccat-kovaplus.ko: extra/roccat-common.ko extra/roccat.ko
> kernel/drivers/hid/hid-roccat-lua.ko: extra/roccat-common.ko
> kernel/drivers/hid/hid-roccat-pyra.ko: extra/roccat-common.ko extra/roccat.ko
> kernel/drivers/hid/hid-roccat-savu.ko: extra/roccat-common.ko extra/roccat.ko
> extra/koneplus.ko: extra/roccat-common.ko extra/roccat.ko
> extra/roccat.ko:
> extra/kone.ko: extra/roccat.ko
> extra/pyra.ko: extra/roccat-common.ko extra/roccat.ko
> extra/arvo.ko: extra/roccat-common.ko extra/roccat.ko
> extra/kovaplus.ko: extra/roccat-common.ko extra/roccat.ko
> extra/savu.ko: extra/roccat-common.ko extra/roccat.ko
> extra/konepure.ko: extra/roccat-common.ko extra/roccat.ko
> extra/isku.ko: extra/roccat-common.ko extra/roccat.ko
> extra/roccat-common.ko:
> extra/lua.ko: extra/roccat-common.ko
>
> $ grep roccat /lib/modules/$(uname -r)/modules.symbols
>
> alias symbol:roccat_connect roccat
> alias symbol:roccat_connect hid_roccat
> alias symbol:roccat_disconnect roccat
> alias symbol:roccat_disconnect hid_roccat
> alias symbol:roccat_common2_send roccat_common
> alias symbol:roccat_common2_send hid_roccat_common
> alias symbol:roccat_common2_receive roccat_common
> alias symbol:roccat_common2_receive hid_roccat_common
> alias symbol:roccat_common2_send_with_status roccat_common
> alias symbol:roccat_common2_send_with_status hid_roccat_common
> alias symbol:roccat_report_event roccat
> alias symbol:roccat_report_event hid_roccat
>
>
>
> * depmod from kmod
>
> $ grep roccat /lib/modules/$(uname -r)/modules.dep
>
> kernel/drivers/hid/hid-roccat.ko:
> kernel/drivers/hid/hid-roccat-common.ko:
> kernel/drivers/hid/hid-roccat-arvo.ko:

It's weird we are creating an invalid index in this case. I'll take a
look on adding some warnings.


> kernel/drivers/hid/hid-roccat-isku.ko:
> kernel/drivers/hid/hid-roccat-kone.ko:
> kernel/drivers/hid/hid-roccat-koneplus.ko:
> kernel/drivers/hid/hid-roccat-kovaplus.ko:
> kernel/drivers/hid/hid-roccat-lua.ko:
> kernel/drivers/hid/hid-roccat-pyra.ko:
> kernel/drivers/hid/hid-roccat-savu.ko:
> extra/roccat.ko:
> extra/roccat-common.ko:
>
> $ grep roccat /lib/modules/$(uname -r)/modules.symbols
>
> alias symbol:roccat_disconnect roccat
> alias symbol:roccat_common2_receive roccat_common
> alias symbol:roccat_report_event roccat
> alias symbol:roccat_connect roccat
> alias symbol:roccat_common2_send roccat_common
> alias symbol:roccat_common2_send_with_status roccat_common
>
>
>
> [1] http://sourceforge.net/projects/roccat/files/linux/kmod-roccat/kmod-roccat-0.8.2.tar.bz2/download


Thanks
Lucas de Marchi
