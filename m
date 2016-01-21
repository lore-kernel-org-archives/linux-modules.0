Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47947 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015AbcAUUQz (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 21 Jan 2016 15:16:55 -0500
Date: Thu, 21 Jan 2016 21:16:53 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC PATCH v2 00/11] vfss: support for a common kernel file
 loader
Message-ID: <20160121201653.GD20964@wotan.suse.de>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Mon, Jan 18, 2016 at 10:11:15AM -0500, Mimi Zohar wrote:
> For a while it was looked down upon to directly read files from Linux.
> These days there exists a few mechanisms in the kernel that do just this
> though to load a file into a local buffer. There are minor but important
> checks differences on each, we should take all the best practices from
> each of them, generalize them and make all places in the kernel that
> read a file use it.[1]
> 
> One difference is the method for opening the file.  In some cases we
> have a file, while in other cases we have a pathname or a file descriptor.
> 
> Another difference is the security hook calls, or lack of them.  In
> some versions there is a post file read hook, while in others there
> is a pre file read hook.
> 
> This patch set is the first attempt at resolving these differences.  It
> does not attempt to merge the different methods of opening a file, but
> defines a single common kernel file read function with two wrappers.
> Although this patch set defines two new security hooks for pre and post
> file read, it does not attempt to merge the existing security hooks.
> That is left as future work.
> 
> Changelog v2:
> - Combined the "ima: measuring/appraising files read by the kernel" patches
> with this patch set to simplify review.
> - Split the "ima: measure and appraise kexec image and initramfs" patch to
> separate IMA from the kexec changes.
> 
> The latest version of these patches can be found in the next-kernel-read-v2
> branch of:
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> 
> [1] Taken from Luis Rodriguez's wiki -
> http://kernelnewbies.org/KernelProjects/common-kernel-loader

Did 0-day bot get a chance to test this tree? If not can it
be added ?

  Luis
