Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA18107A0
	for <linux-modules@vger.kernel.org>; Mon, 24 Jun 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719254777; cv=none; b=Ai/axz6F3BYUwxW3p9OyvF/lrPsjj6gQA+ydXvFFoUBLWgOC0gGj8W8bPqcFHcC8GwCXv0cYUtijxOZMIAnbyC2kjzt5eiTW80TtwD8qJgDVMZRU6a8YCk2PS4Evxh9xz8bDjt9meDvGoSPcXuAqXhEFZcAB34c4mRJr5VwRRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719254777; c=relaxed/simple;
	bh=3a7ubh9wiYHiZyjHa4djPYzuPhIKvCoP9C7iE75Xbmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND56cPuahKI2CpoemJHLryLn/ejdZznhOjceL2pn1JmehAklgLZYQjUIYCSFPQZwKklJ5cHjYzS79X2Zqpmj4zAMA5xz103lDQeAePp4BuhGAe8zW+y/J9BcGvnGU3KP62MJy+sL5uUhPoc4HEPUolU2gXJheymYMD8WmQzZsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jLyW9sb4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CRz3iMrr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jLyW9sb4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CRz3iMrr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jLyW9sb4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CRz3iMrr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jLyW9sb4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CRz3iMrr"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A55B91F7CC;
	Mon, 24 Jun 2024 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719254773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pg9JaMLKIEWwjyoAkggHu1+bHbYF0uI/6icpohQjf9s=;
	b=jLyW9sb4xBlQjj2/xW5lpbRogrrXTkTIwNp+e9pSApF2RcwWVjf8x1Fn6nH5hnLwBZT00j
	oLQmvbX2FQVe8D341RNZs0KaW97wsf0xQRbkHYvRDV/Ar8Gvk6DGMGuZFB6uueV1hUiFl/
	PhlARVRcn5XOOKJ2YE1fDtuhU4qjJSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719254773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pg9JaMLKIEWwjyoAkggHu1+bHbYF0uI/6icpohQjf9s=;
	b=CRz3iMrrVy9gdrp7r1YlgC3tk79yPf0mQaf58S3bmdEBodRvglmRLLtWzrbIcAUgwDMgmj
	AcagmZSYdjmoQYDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719254773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pg9JaMLKIEWwjyoAkggHu1+bHbYF0uI/6icpohQjf9s=;
	b=jLyW9sb4xBlQjj2/xW5lpbRogrrXTkTIwNp+e9pSApF2RcwWVjf8x1Fn6nH5hnLwBZT00j
	oLQmvbX2FQVe8D341RNZs0KaW97wsf0xQRbkHYvRDV/Ar8Gvk6DGMGuZFB6uueV1hUiFl/
	PhlARVRcn5XOOKJ2YE1fDtuhU4qjJSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719254773;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pg9JaMLKIEWwjyoAkggHu1+bHbYF0uI/6icpohQjf9s=;
	b=CRz3iMrrVy9gdrp7r1YlgC3tk79yPf0mQaf58S3bmdEBodRvglmRLLtWzrbIcAUgwDMgmj
	AcagmZSYdjmoQYDQ==
Date: Mon, 24 Jun 2024 20:46:12 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Yunseong Kim <yskelg@gmail.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH] libkmod: fix result of comparison of unsigned enum in
 kmod_dump_index()
Message-ID: <20240624184612.GT19642@kitsune.suse.cz>
References: <20240622061321.9005-2-yskelg@gmail.com>
 <20240624074956.GR19642@kitsune.suse.cz>
 <72c771f3-250f-430b-a7d9-f233e929ccd3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72c771f3-250f-430b-a7d9-f233e929ccd3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

Hello,

On Tue, Jun 25, 2024 at 02:40:23AM +0900, Yunseong Kim wrote:
> Hi Michal,
> 
> On 6/24/24 4:49 오후, Michal Suchánek wrote:
> > Hello,
> > 
> > On Sat, Jun 22, 2024 at 03:13:22PM +0900, yskelg@gmail.com wrote:
> >> From: Yunseong Kim <yskelg@gmail.com>
> >>
> >> This patch fix compiler warning in kmod_dump_index()
> >>
> >> libkmod/libkmod.c:989:11: warning: result of comparison of unsigned enum
> >> expression < 0 is always false [-Wtautological-unsigned-enum-zero-compare]
> >>   989 |         if (type < 0 || type >= _KMOD_INDEX_MODULES_SIZE)
> >>       |             ~~~~ ^ ~
> >>
> >> My compiler version.
> >>
> >> $ clang -v
> >> clang version 18.1.6 (Fedora 18.1.6-3.fc40)
> > 
> > If you look eg. here
> > https://stackoverflow.com/questions/2579230/signedness-of-enum-in-c-c99-c-cx-gnu-c-gnu-c99
> > 
> > you can see that it is not *guaranteed* that the enum is unsigend, and
> > consequently a value lower than zero can be passed in.
> > 
> > Consequently the bug is in your compiler issuing the warning. While in
> > that specific C implementation the value cannot be negative in general
> > it can.
> > 
> > Finally I see that _KMOD_INDEX_MODULES_SIZE is defined separately from
> > the enumeration itself, and would be prone to getting slale if the
> > enumeration is ever updated.
> > 
> > Making it part of the enumeration so it automatically gets the value of
> > last used index type incremented by one would be probably less
> > error-prone. In the kernel there is also a pattern of defining *_LAST as
> > an alias to the last used value in the enumeration, and then
> > _KMOD_INDEX_MODULES_SIZE coud be defined as this last value incremented
> > by 1.
> > 
> > Thanks
> > 
> > Michal
> 
> Thank you for the code review Michal, I understand your point. Would it
> be acceptable if we don't need to make any further adjustments to the
> warning?

As already said the warning should be adjusted on the compiler side.
That is either report the problem to the compiler authors so they can
fix it or disable the warning with a compiler option if it's bothering
you.

> >> diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> >> index 213b424..fcb619b 100644
> >> --- a/libkmod/libkmod.c
> >> +++ b/libkmod/libkmod.c
> >> @@ -986,7 +986,7 @@ KMOD_EXPORT int kmod_dump_index(struct kmod_ctx *ctx, enum kmod_index type,
> >>  	if (ctx == NULL)
> >>  		return -ENOSYS;
> >>  
> >> -	if (type < 0 || type >= _KMOD_INDEX_MODULES_SIZE)
> >> +	if (type >= KMOD_INDEX_MODULES_DEP || type >= _KMOD_INDEX_MODULES_SIZE)
> > 
> > Why are you adding a duplicate check here?
> 
> I also think my code is really wrong. I'm sorry.

These two are defined in different files, so it's understandable that
you might get confused about their relationship. Defining them in one
place could make the code more robust and easier to understand. It
would, however, not address the warning. It's a separate problem related
to this enum definition.

Thanks

Michal
