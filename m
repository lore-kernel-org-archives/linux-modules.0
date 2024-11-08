Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61661E8843;
	Fri,  8 Nov 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080989; cv=none; b=SpFPpsw11Jkb4jyH826lk//ZcetQtb20HGsZ8tvaK6KcgidVuhjwWmftbz+VI8wD4tJN1gC71vMB+5tu8DrU5c3fGHaqeFAHEhCaTiRvs9DdDkieuQPsE9OptN3AvIf+EsLqIi1K34wyoaJHZxOMfVhNlV31+kzXWsCYSLCUT+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080989; c=relaxed/simple;
	bh=bNWyHlQLaS8jAp8LNi4V7sTSeKnqBJqlVvZv8dA8ivY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRE3U18eDSz8B4z4r5PeXUYskJqPu1uYuBBT1PwHmZo/O3A8/a1eNZAF+fwH1W1yPJHCzLzLdHuWNkUb3afYm6wyuf/5Zvk3DwRH+squzl9qStrxdV2cxrt91XDLINCChqadM4raI1qDQLy/ivns5mVBUMz7vdcp+xaAGrIWUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCyBO3vz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCyBO3vz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30482C4CECD;
	Fri,  8 Nov 2024 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731080989;
	bh=bNWyHlQLaS8jAp8LNi4V7sTSeKnqBJqlVvZv8dA8ivY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aCyBO3vzPfTH8zliCXHDrREiMkW76T5M8zbOv4TgLRq8SichqyTUmzA87zdassNmm
	 Y4SLCKA8jITOk1hQzhDyCIWde86UOJJOCEoSOZiI3plMohh+LGZd4jxIKfD+1wsBL1
	 q2Yj8K7X5lnAuiO0OOgMNwSaXD0WLdD3qTmCrmMvCAZeZFapm8uFefUuB7iMPubVDe
	 z3Ti9R4hVF5HHQwShI6Y3ORES0KkC9bveSCvFIqYgbH8hakCe6M90F1k4teysRXned
	 aAY+M6pvzar7eBlp6SidJbyK2FTBv+yNlD/NgGevEtEyUGxRK4SSVr8E6Ob0jvBfgW
	 Ag4Jd6ykQ1FbA==
Date: Fri, 8 Nov 2024 07:49:47 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Daniel Gomez <da.gomez@samsung.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org
Cc: Mike Rapoport <rppt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
Message-ID: <Zy4zGy9aoQ1-Qokg@bombadil.infradead.org>
References: <87cylj7v6x.ffs@tglx>
 <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com>
 <877cbr7qed.ffs@tglx>
 <50551f21-6e90-3556-7a3d-8b81a042f99c@huawei.com>
 <87a5gm5tb3.ffs@tglx>
 <ZtuPSIFsV8C3UZW8@bombadil.infradead.org>
 <Zuv0nmFblHUwuT8v@bombadil.infradead.org>
 <ZvJomuNWjtHYDcsW@kernel.org>
 <8bd5e396-7583-435e-bafc-7d092a31f4ff@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bd5e396-7583-435e-bafc-7d092a31f4ff@csgroup.eu>

+ Other new module maintainers

On Fri, Nov 08, 2024 at 09:12:03AM +0100, Christophe Leroy wrote:
> Hi Luis,
> 
> Le 24/09/2024 à 09:22, Mike Rapoport a écrit :
> > On Thu, Sep 19, 2024 at 02:53:34AM -0700, Luis Chamberlain wrote:
> > > On Fri, Sep 06, 2024 at 04:24:56PM -0700, Luis Chamberlain wrote:
> > > > On Thu, Sep 05, 2024 at 11:44:00AM +0200, Thomas Gleixner wrote:
> > > > > Now you at least provided the information that the missing cleanup in
> > > > > the init() function is not the problem. So the obvious place to look is
> > > > > in the module core code whether there is a failure path _after_
> > > > > module->init() returned success.
> > > > > 
> > > > > do_init_module()
> > > > >          ret = do_one_initcall(mod->init);
> > > > >          ...
> > > > > 	ret = module_enable_rodata_ro(mod, true);
> > > > > 	if (ret)
> > > > > 		goto fail_mutex_unlock;
> > > > > 
> > > > > and that error path does _not_ invoke module->exit(), which is obviously
> > > > > not correct. Luis?
> > > > 
> > > > You're spot on this needs fixing.
> > > 
> > > Christophe, this is a regression caused by the second hunk of your commit
> > > d1909c0221739 ("module: Don't ignore errors from set_memory_XX()") on v6.9.
> > > Sadly there are a few issues with trying to get to call mod->exit():
> > > 
> > > - We should try try_stop_module()  and that can fail
> > > - source_list may not be empty and that would block removal
> > > - mod->exit may not exist
> > > 
> > > I'm wondering if instead we should try to do the module_enable_rodata_ro()
> > > before the init, but that requires a bit more careful evaluation...
> > 
> > There is ro_after_init section, we can't really make it RO before ->init()
> 
> Surprisingly I never received Luis's email

So odd..

> allthough I got this answer from Mike that I overlooked.
> 
> So coming back here from
> https://lore.kernel.org/all/ZyQhbHxDTRXTJgIx@bombadil.infradead.org/
> 
> As far as I understand, indeed once init is called it is too late to fail,

Partly yes, party no. Party yes in that its a can of worms we have not
had to deal with before, and also I worry about deadlocks, and the code
to address this seems complex. right ?


> Especially when the module has no exit() path or when
> CONFIG_MODULE_UNLOAD is not built in.

That's exactly the other extreme case I fear for.

> So the only thing we can do then is a big fat warning telling
> set_memory_ro() on ro_after_init memory has failed ?

I suspect this is more sensible to do.

> Maybe we should try and change it to RO then back to RW before calling init,
> to be on a safer side hopping that if change to RO works once it will work
> twice ?

That's another approach wich could work, if we proove that this does
work, it's a nice best effort and I think less or a mess to the codebase
then special-casing the error handling of trying to deal with the
driver's exit.

Daniel Gomez has been looking at this, so his feedback here would be
valuable.

  Luis
