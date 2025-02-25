Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604F21A2567;
	Tue, 25 Feb 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504294; cv=none; b=efwb7XZ+INT5WV3Tn5RVcJyiRVMuXsPPgO0Ambu6KIMNab9KzAGdP/IPXLsEX3wyJi4EVdVwP49ZkiuhyDNLl1Ousm4F190AEdWyAWZU10nY/RkGEq28nSfYv0RYpzqM1uH2IIIhHPA2+I4u77vhVmFicqe+Ggo3NLR8Manz60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504294; c=relaxed/simple;
	bh=aDY7TR4VTCyrtKDgPwDtxqtP5TeeW3MyhnHze/eIGxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIEsU0a/FfMVQHnwisKYJugMKHJyjdGOP46qAPGZvaiNR7ocnesXS7oxt8yBjNmC1eqHprrcVh7tPxUFEcmRP8orik3d8aFJRfuAaZdTyXnmDZ4XcS6LJHA+LkdBKieVH5ajITl2RAhMIPVe1nQ83VbnsIE4XgadBBcNXuGoYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BSdiKB3i; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BSdiKB3i"
Received: by linux.microsoft.com (Postfix, from userid 1152)
	id EAB6A203CDED; Tue, 25 Feb 2025 09:24:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EAB6A203CDED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740504285;
	bh=plsJhPJfP5AMhTGoZAobBxfnGCypJcfkAH+Ajvih/uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSdiKB3inbR3DLGJIOt6h+/rE0ZLTI6+fMQCfbGGcvPOc78AGZAp4kbCsMRcLOpwO
	 SJ/rxaScF9xxJ43Me+3dtGYwaaCSlchcAOnx8qZvKtaDIF0KPbuJge8xqEqcCswi23
	 zyNNcqRfFsBfSU2wNRRavAmCD8P4QIiFxKQlJ1K8=
Date: Tue, 25 Feb 2025 09:24:45 -0800
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	code@tyhicks.com, christophe.leroy@csgroup.eu, hch@infradead.org,
	mcgrof@kernel.org, frkaya@linux.microsoft.com,
	vijayb@linux.microsoft.com, linux@weissschuh.net,
	samitolvanen@google.com, da.gomez@samsung.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org
Subject: Re: [PATCH v3 2/4] kernel: refactor lookup_or_create_module_kobject()
Message-ID: <20250225172445.GA28595@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
 <20250211214842.1806521-3-shyamsaini@linux.microsoft.com>
 <4039ec74-8b46-417e-ad71-eff22239b90f@suse.com>
 <87wmdjo9yp.fsf@prevas.dk>
 <e8ba9f36-e33d-4c53-9d34-ff611cb1c221@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8ba9f36-e33d-4c53-9d34-ff611cb1c221@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Petr,

Thank you for the reviews

On Tue, Feb 25, 2025 at 09:33:10AM +0100, Petr Pavlu wrote:
> On 2/21/25 11:42, Rasmus Villemoes wrote:
> > On Thu, Feb 13 2025, Petr Pavlu <petr.pavlu@suse.com> wrote:
> > 
> >> On 2/11/25 22:48, Shyam Saini wrote:
> >>> In the unlikely event of the allocation failing, it is better to let
> >>> the machine boot with a not fully populated sysfs than to kill it with
> >>> this BUG_ON(). All callers are already prepared for
> >>> lookup_or_create_module_kobject() returning NULL.
> >>>
> >>> This is also preparation for calling this function from non __init
> >>> code, where using BUG_ON for allocation failure handling is not
> >>> acceptable.
> >>
> >> I think some error reporting should be cleaned up here.
> >>
> >> The current situation is that locate_module_kobject() can fail in
> >> several cases and all these situations are loudly reported by the
> >> function, either by BUG_ON() or pr_crit(). Consistently with that, both
> >> its current callers version_sysfs_builtin() and kernel_add_sysfs_param()
> >> don't do any reporting if locate_module_kobject() fails; they simply
> >> return.
> >>
> >> The series seems to introduce two somewhat suboptimal cases.
> >>
> >> With this patch, when either version_sysfs_builtin() or
> >> kernel_add_sysfs_param() calls lookup_or_create_module_kobject() and it
> >> fails because of a potential kzalloc() error, the problem is silently
> >> ignored.
> >>
> > 
> > No, because (IIUC) when a basic allocation via kzalloc fails, the kernel
> > complains loudly already; there's no reason for every caller of
> > kmalloc() and friends to add their own pr_err("kmalloc failed"), that
> > just bloats the kernel .text.
> 
> I wasn't suggesting to log a kmalloc() error specifically. The idea was
> that if lookup_or_create_module_kobject() fails for whatever reason,
> kernel_add_sysfs_param() and version_sysfs_builtin() should log the
> failure to create/get the kobject.
> 
> > 
> >> Similarly, in the patch #4, when module_add_driver() calls
> >> lookup_or_create_module_kobject() and the function fails, the problem
> >> may or may not be reported, depending on the error.
> >>
> >> I'd suggest something as follows:
> >> * Drop the pr_crit() reporting in lookup_or_create_module_kobject().
> > 
> > No, because that reports on something other than an allocation failing
> > (of course, it could be that the reason kobject_init_and_add or
> > sysfs_create_file failed was an allocation failure, but it could
> > also be something else), so reporting there is the right thing to do.
> 
> The error message says:
> pr_crit("Adding module '%s' to sysfs failed (%d), the system may be unstable.\n", name, err);
> 
> I think it was appropriate for locate_module_kobject() to do this error
> reporting when the function was only called by code in kernel/params.c
> and in the boot context. Now that the patch makes the function available
> to external callers, I'm not sure if it should remain reporting this
> error.
> 
> The function itself shouldn't directly make the system unstable when it
> fails. Each caller can appropriately determine how to handle the error.
> Functions kernel_add_sysfs_param() and version_sysfs_builtin() don't
> have much of an option and can only log it, but module_add_driver()
> could roll back its operation.
> 

before this patch series [1] kset_find_obj() was called in module_add_driver()
and the function immediately returned when no valid module_kobject was found,

module_add_driver returns immediately if some error is encountered or module_kobject
is not found in lookup_or_create_module_kobject()
Since module_kobject() is anyway no-op if it [2] returns early so it shouldn't require
any rollback, right?

Assuming rollback is not required for module_add_driver() in lookup_or_create_module_kobject()
failure scenario, what should be the appropriate messaging from pr_crit() if it
fails in module_add_driver()?

[1] https://elixir.bootlin.com/linux/v6.14-rc4/source/drivers/base/module.c#L48
[2] https://elixir.bootlin.com/linux/v6.14-rc4/source/drivers/base/module.c#L58

Thanks,
Shyam
