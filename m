Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45099 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932182AbcBDT5b (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 4 Feb 2016 14:57:31 -0500
Date: Thu, 4 Feb 2016 20:57:29 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 18/22] kexec: replace call to copy_file_from_fd() with
 kernel version
Message-ID: <20160204195729.GG12481@wotan.suse.de>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-19-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454526390-19792-19-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 03, 2016 at 02:06:26PM -0500, Mimi Zohar wrote:
> Replace copy_file_from_fd() with kernel_read_file_from_fd().
> 
> Two new identifiers named READING_KEXEC_IMAGE and READING_KEXEC_INITRAMFS
> are defined for measuring, appraising or auditing the kexec image and
> initramfs.
> 
> Changelog v3:
> - return -EBADF, not -ENOEXEC
> - identifier change
> - moved copy_file_from_fd() to a separate patch
> - defer support for IMA
> v1:
> - re-order and squash the kexec patches
> v0: ima: measure and appraise kexec image and initramfs (squashed)
> - rename ima_read_hooks enumeration to ima_policy_id
> - use kstat file size type loff_t, not size_t
> - add union name "hooks" to fix sparse warning
> - Calculate the file hash from the in memory buffer
> (suggested by Dave Young)
> - Rename ima_read_and_process_file() to ima_hash_and_process_file()
> - replace individual case statements with range:
>         KEXEC_CHECK ... IMA_MAX_READ_CHECK - 1
> - Instead of ima_read_and_process_file() allocating memory, the caller
> allocates and frees the memory.
> - Moved the kexec measurement/appraisal call to copy_file_from_fd(). The
> same call now measures and appraises both the kexec image and initramfs.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis
