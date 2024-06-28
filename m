Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A841CCCB0;
	Fri, 28 Jun 2024 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595521; cv=none; b=lyi+JErPZp/4wilRWKJFtYBWQambhwTkak3MjYKW7Xd51peJGc9tIWAS2mYNyaqAeNmTX9XkdSoqh+yALnZ34TZxMK5OYVr2IhP/rY1PSl/UkrU7sbdAJHSQsDR70VClMANxWIyjO1lz84qFC66LrGWIxfDdIKjJXWzvLhG3AeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595521; c=relaxed/simple;
	bh=x6j73uoCRrZ14yA3p55yPP6y7FL+Uk8sLbq29Ko5E/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HedZ2xHMs36f7H2YZ4FWRqPi96fp4JFIzYQsQxwXacdvC+JqO7jzVupvYGt7uvkM6OsQlwGVyxvWUZF4fhsW5rpO983w2K5B9lwwRQgtb4LElIMzW9AdCaf1OrNq3U1BABGEN1JLFNNj+jM9u5F+CrM2aaoqdWbAOYRsqgLJ+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GVgXdC7E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GVgXdC7E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O7+BgIEUquUKXJpFeq9QGAUW5FT/jrmi5BFL0thD5sA=; b=GVgXdC7EJuEzd74wgwyZ5FwRom
	dzWhaI0TFTg/RWPZ+R3b6EEsG3B3UforTugwa1SO0oraiF/+YqoUFOOYopUs3BGleJffU1gcXDGGn
	VQIniY7lH6eBBxlrPo8sYWNOmwmZlNy+iI9jeWIo2yoPeOQbKviosSx2+sYxMe0QgxLRXW4PrXlQ/
	B0IzjGnrfr/eakrN1gykJWkBssEPEJ8OjcR7bD5UCChFfsnVkE/1jd69G5v687id+7Rf9TtvvG1Cl
	F9DdDmd0TIIMelYcvmaybgXf6q+1ib4nv0ssa+PI0IxkA51zRo1TmjUBCkfyRSdXXN1tfStoxfgv1
	vjjZNb2w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNFLc-0000000EUqx-0579;
	Fri, 28 Jun 2024 17:25:20 +0000
Date: Fri, 28 Jun 2024 10:25:19 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Daniel von Kirschten <danielkirschten@gmail.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.10.0-rc2] kernel/module: avoid panic on loading broken
 module
Message-ID: <Zn7x_9BpJLwYSORn@bombadil.infradead.org>
References: <230772fc-1076-4afb-8f7a-e7c402548c3b@gmail.com>
 <ZnHm-5oljP8_5dFB@bombadil.infradead.org>
 <82da9ad9-6a79-4edf-b38f-ef000b68c50a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82da9ad9-6a79-4edf-b38f-ef000b68c50a@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Jun 21, 2024 at 04:05:27PM +0200, Daniel von Kirschten wrote:
> Am 18.06.2024 um 21:58 schrieb Luis Chamberlain:
> > On Thu, Jun 06, 2024 at 03:31:49PM +0200, Daniel v. Kirschten wrote:
> > > If a module is being loaded, and the .gnu.linkonce.this_module section
> > > in the module's ELF file does not have the WRITE flag, the kernel will
> > > map the finished module struct of that module as read-only.
> > > This causes a kernel panic when the struct is written to the first time
> > > after it has been marked read-only. Currently this happens in
> > > complete_formation in kernel/module/main.c:2765 when the module's state is
> > > set to MODULE_STATE_COMING, just after setting up the memory protections.
> > 
> > How did you find this issue?
> 
> In a university course I got the assignment to manually craft a loadable .ko
> file, given only a regular object file, without using Kbuild. During testing
> my module files, most of them were simply (correctly) rejected by the kernel
> with an appropriate error message, but at some point I ran into this exact
> kernel panic, and investigated it to understand why my module file was
> invalid.

OK, then the commit log should describe that this doesn't fix any known
real world issue, but rather a custom crafted module without the regular
module build system.

> > > Down the line, this seems to lead to unpredictable freezes when trying to
> > > load other modules - I guess this is due to some structures not being
> > > cleaned up properly, but I didn't investigate this further.
> > > 
> > > A check already exists which verifies that .gnu.linkonce.this_module
> > > is ALLOC. This patch simply adds an analogous check for WRITE.
> > 
> > Can you check to ensure our modules generated have a respective check to
> > ensure this check exists at build time? That would proactively inform
> > userspace when a built module is not built correctly, and the tool
> > responsible can be identified.
> 
> See above - I don't think it's possible to create such a broken module file
> with any of "official" tools.

That should be clearly stated on the commit log.

> I haven't looked too deeply into how Kbuild
> actually builds modules, but as far as I know, the user doesn't even come
> into contact with this_module w

Consider that a next level university assignment and is more useful to the world
than this debug message. Because above you suggest "I don't think", go
out and now be sure.

> hen using the regular toolchain, because
> Kbuild is responsible for creating the .this_module section. And Kbuild of
> course creates it with the correct flags. So if I understand correctly,

...

> this
> problem can only occur when the module was built by some external tooling
> (or manually, in my case).

Who would create custom modules without the Linux kernel module build
system, and what uses does that provide? It seems you are proving why
this would be terribly silly thing to do.

Now, the *value* your change has is it can prevent a crash in case of a
corrupted module, which *can* occur, consider an odd filesystem
live corruption, at least this would be caught at module load attempt
and not crash. That's worth committing for this reason but your commit
log really needs much more clarity. Why? Because stupid bots want to
assign stupid CVEs for anything that seems like a security issue and
this could escalate to such type of things. Providing clarity helps
system integrators decide if they want to backport this sort of patch.
Providing clarify on the chances of this happening and how we think it
can happen helps a lot.

If you want to be more proactive, try to enhance userspace kmod modprobe
so that this is also verified.

  Luis
