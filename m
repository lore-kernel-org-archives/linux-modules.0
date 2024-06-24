Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D9182B3
	for <linux-modules@vger.kernel.org>; Mon, 24 Jun 2024 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215403; cv=none; b=G4oYCY1TE+N9KU+BxFT/y1dpKREGNPlAUxfl2U0FG3kP/layHWd/oiVYwuD+rijKhe+zQ/FB4bQkM3Cv+XBL70QQefQI5u3gh1SceBqd/HS42nMyc/TgI/8Y1MCp8KPvHylICDVW49o0jc6FLEzZEVQBcHSObmiw4h59QMGesV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215403; c=relaxed/simple;
	bh=yK8swwLjwHxw4GRUcEI1z2r1qCQke05jsckP2NFH7Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPIHNyoTTdgSN5gdRvvrcUnbQqOeO39eQjM/LoTF+O7blLtLXQMQNUW37HGWkubR2V0S7avbvnJYLjxMiPWSFc4YLXp/+qgmHfBwLftZllEVtwfVgUWIc17UUf89ANUo4diPKLYE0sTmqJkqCs19aRUVdPuYLSEI67GDKGJa3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DHtpOmFe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uWJ+4Nsr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yHUtyjSB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pRxTzc4C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DHtpOmFe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uWJ+4Nsr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yHUtyjSB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pRxTzc4C"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FD111F7B8;
	Mon, 24 Jun 2024 07:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719215399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6y0fkdMN3UEg4Gvx41VIjtZHhfzAHBiIkWDES9mG28=;
	b=DHtpOmFeaSuEaxlt6ta4XNXm0f4axruJcv3jYhm8LO3jg80xvZ/fK1yvFtHPzV6zIpCZU0
	LUV2vbfixeLKHr/GL25CGLxv4jxnslY7Ouiyg6MYOzSP1LZk1HWkSVCGBnGX24GvXuwgwb
	4J22EsJMWNENKhYcuiMDPtxKGYcILo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719215399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6y0fkdMN3UEg4Gvx41VIjtZHhfzAHBiIkWDES9mG28=;
	b=uWJ+4Nsrtx1xmGLNePVR/A9T06LVnI9R6V4Bt307kGr/qwj4yTJLGGuktukqPXuNgFwDwi
	T7lZZKjvV45nSnDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719215397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6y0fkdMN3UEg4Gvx41VIjtZHhfzAHBiIkWDES9mG28=;
	b=yHUtyjSB7VROw9lsoO3C9uVyKe/uyyFqpx3AiRFQ0TsYVlUQAoP4pau2rXkQa9sFWlqYbx
	FVli5q1bBcF4lxw3wqm66Za3dg+VsGzFSYBQ9q1cC7Fp0QiJsBZflc63R8pzothg7MeHlL
	AdVg9g6G1b2mPxsy+mFeiiQ1lA5dmqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719215397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6y0fkdMN3UEg4Gvx41VIjtZHhfzAHBiIkWDES9mG28=;
	b=pRxTzc4CtL7DmVk8jLofvzxAfn4miSNpR88s30zriAhbuKWh9j0zEgjTnltNLSnLLY07XC
	iqwng27B3w11JiAA==
Date: Mon, 24 Jun 2024 09:49:56 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: yskelg@gmail.com
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH] libkmod: fix result of comparison of unsigned enum in
 kmod_dump_index()
Message-ID: <20240624074956.GR19642@kitsune.suse.cz>
References: <20240622061321.9005-2-yskelg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622061321.9005-2-yskelg@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stackoverflow.com:url,kitsune.suse.cz:helo]

Hello,

On Sat, Jun 22, 2024 at 03:13:22PM +0900, yskelg@gmail.com wrote:
> From: Yunseong Kim <yskelg@gmail.com>
> 
> This patch fix compiler warning in kmod_dump_index()
> 
> libkmod/libkmod.c:989:11: warning: result of comparison of unsigned enum
> expression < 0 is always false [-Wtautological-unsigned-enum-zero-compare]
>   989 |         if (type < 0 || type >= _KMOD_INDEX_MODULES_SIZE)
>       |             ~~~~ ^ ~
> 
> My compiler version.
> 
> $ clang -v
> clang version 18.1.6 (Fedora 18.1.6-3.fc40)

If you look eg. here
https://stackoverflow.com/questions/2579230/signedness-of-enum-in-c-c99-c-cx-gnu-c-gnu-c99

you can see that it is not *guaranteed* that the enum is unsigend, and
consequently a value lower than zero can be passed in.

Consequently the bug is in your compiler issuing the warning. While in
that specific C implementation the value cannot be negative in general
it can.

Finally I see that _KMOD_INDEX_MODULES_SIZE is defined separately from
the enumeration itself, and would be prone to getting slale if the
enumeration is ever updated.

Making it part of the enumeration so it automatically gets the value of
last used index type incremented by one would be probably less
error-prone. In the kernel there is also a pattern of defining *_LAST as
an alias to the last used value in the enumeration, and then
_KMOD_INDEX_MODULES_SIZE coud be defined as this last value incremented
by 1.

Thanks

Michal

> 
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> ---
>  libkmod/libkmod.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> index 213b424..fcb619b 100644
> --- a/libkmod/libkmod.c
> +++ b/libkmod/libkmod.c
> @@ -986,7 +986,7 @@ KMOD_EXPORT int kmod_dump_index(struct kmod_ctx *ctx, enum kmod_index type,
>  	if (ctx == NULL)
>  		return -ENOSYS;
>  
> -	if (type < 0 || type >= _KMOD_INDEX_MODULES_SIZE)
> +	if (type >= KMOD_INDEX_MODULES_DEP || type >= _KMOD_INDEX_MODULES_SIZE)

Why are you adding a duplicate check here?

>  		return -ENOENT;
>  
>  	if (ctx->indexes[type] != NULL) {
> -- 
> 2.45.2
> 
