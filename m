Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:60451 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbaB1ReN (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 28 Feb 2014 12:34:13 -0500
Received: by mail-ve0-f175.google.com with SMTP id oz11so132981veb.6
        for <linux-modules@vger.kernel.org>; Fri, 28 Feb 2014 09:34:12 -0800 (PST)
MIME-Version: 1.0
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 28 Feb 2014 10:33:52 -0700
Message-ID: <CALCETrXtLvaJBvKmrT9jx_fRqVuKO1Xid8_vRoT1Nb+7HOZH2w@mail.gmail.com>
Subject: Making depmod, etc more flexible?
To: linux-modules@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

I'm working on virtme
(https://git.kernel.org/cgit/utils/kernel/virtme/virtme.git/), a tool
to easily test a kernel without a disk image or any need to install
that kernel.  I want to have full support for loading modules from a
kernel tree, but depmod is getting in the way.

What I think I want is a way to generate modules.dep, etc in a
subdirectory of the kernel build directory.  The hierarchy needs to be
such that:

 - modprobe --show-depends would work.
 - I could symlink and/or bind-mount things into /lib/modules so that
modprobe, udev, etc all work.

One approach that should work:

.tmp_moddep/build: a symlink to '..'
.tmp_moddep/modules.dep, etc: the usual, with module paths that point
into build/

The problem is that getting depmod to generate anything remotely like
this is basically impossible.

Here are two changes to depmod that would, I think, make this possible:

1. Add --moddir, an option to specify the target directory directly.
That is, if --moddir is used, then -b would be illegal, the kernel
version could not be specified, and cfg.dirname would be set to the
argument of --moddir, literally.

2. Allow relative paths to modules on the command line.  Such paths
would be interpreted relative to cfg.dirname.  (That would probably be
easiest if depmod would chdir into cfg.dirname.)

To finish the job, modprobe would need a --moddir argument as well.

Thoughts?  Is there a different approach I should be taking here?

--Andy
