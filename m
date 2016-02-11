Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35219 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbcBKIrn (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 11 Feb 2016 03:47:43 -0500
MIME-Version: 1.0
In-Reply-To: <1455156500.2538.268.camel@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
	<CACE9dm9cqE5cu=0+LujHOGP9XyhGNxYfy52Ds6z+pz+fPwF+pw@mail.gmail.com>
	<1455146516.2538.237.camel@linux.vnet.ibm.com>
	<CACE9dm8OJ1cgbKszUG-pCiEMVarUFLLWi_jewVV-JEMGAJsA-g@mail.gmail.com>
	<1455156500.2538.268.camel@linux.vnet.ibm.com>
Date: Thu, 11 Feb 2016 10:47:41 +0200
Message-ID: <CACE9dm-VTDNaEJPGamhMY239LQAPCRYp9rvnwbmZijyo7Vh43g@mail.gmail.com>
Subject: Re: [PATCH v3 19/22] ima: support for kexec image and initramfs
From: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>,
	David Howells <dhowells@redhat.com>, fsdevel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 11, 2016 at 4:08 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Thu, 2016-02-11 at 01:55 +0200, Dmitry Kasatkin wrote:
>> On Feb 11, 2016 1:22 AM, "Mimi Zohar" <zohar@linux.vnet.ibm.com> wrote:
>> >
>> > On Wed, 2016-02-10 at 23:09 +0200, Dmitry Kasatkin wrote:
>> > > On Wed, Feb 3, 2016 at 9:06 PM, Mimi Zohar <zohar@linux.vnet.ibm.com>
>> wrote:
>
>> > > >
>> > > > -       if (read_id == READING_FIRMWARE)
>> > > > +       switch (read_id) {
>> > > > +       case READING_FIRMWARE:
>> > > >                 func = FIRMWARE_CHECK;
>> > > > -       else if (read_id == READING_MODULE)
>> > > > +               break;
>> > > > +       case READING_MODULE:
>> > > >                 func = MODULE_CHECK;
>> > > > +               break;
>> > > > +       case READING_KEXEC_IMAGE:
>> > > > +               func = KEXEC_CHECK;
>> > > > +               break;
>> > > > +       case READING_KEXEC_INITRAMFS:
>> > > > +               func = INITRAMFS_CHECK;
>> > > > +               break;
>> > > > +       default:
>> > > > +               func = FILE_CHECK;
>> > > > +               break;
>> > > > +       }
>> > > >
>> > >
>> > > I would define a separate function like "int ima_read_id_to_func(id)"
>> > > which search over the map
>> > >
>> > > Something like...
>> > >
>> > > struct
>> > > {
>> > >      int id;
>> > >      int func;
>> > > }  map[] = {
>> > >   { .id = READING_FIRMWARE, .fun = FIRMWARE_CHECK },
>> > >    ...
>> > >   { -1, 0 }
>> > > };
>> > >
>> >
>> > So we stay with the duplication (option 1), but clean it up.  That works
>> > for me.
>> >
>>
>> Actually it may be simpler.
>> Just define int idmap[MAX_ID] and assign to every id corresponding func.
>> It will be quick and simple.
>
> Unlike the ima_read_id_to_func() above or the original switch/case
> statement, this method assumes the kernel_read_file_id enumeration stays
> in sync with ima_hooks.

Actually not necessary. You can use array initialization by index,
then you do not need to worry about sync...

static int idmap[] = {
         [READING_FIRMWARE] = FIRMWARE_CHECK,
         [READING_MODULE] = MODULE_CHECK,
         ...
};

> In terms of the  ima_read_id_to_func()
> function, it would iterate over the map[] to find the corresponding .id,
> whereas the current switch/case is a direct lookup.
>

switch is also iteration.

Dmitry
Actually

> Perhaps we should defer making a change for now.
>
> Mimi
>



-- 
Thanks,
Dmitry
