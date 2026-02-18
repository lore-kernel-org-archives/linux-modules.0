Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF633318ED1
	for <linux-modules@vger.kernel.org>; Wed, 18 Feb 2026 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403370; cv=none; b=S+FEfXv9U6q0h51pZpcpYybgECpgG87dPdETzaL6QT5hwPH8o12ndXfeBgfpjmWKwo0TaMhwKHuflEzQWN2sXzF35hM1moDhozPgshq2EFu1fQKF0Krr0rD+SeRv+4IvOQm8u20LSi0+ArQo8c2z2OPxcYiki/kVf/B4toBOcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403370; c=relaxed/simple;
	bh=F1GBs5gqEy3379HyRiPCC6e5C2VAveRNCrKe3sIHkF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zj5zgUHDfV7Ir82kJoXB16rR5TvF6H9SFdo8+egNvoTOBFVPlTggClyHEb6ViC3f1vLEJpBvko6Sbm65tMUiDgnZxb/p62YH1K2asi0CY/mvJTkirS8c+tn9EbDO0RMFmzcIaGVhhcyj71QhCPKiZYXu1NzFZmSsy/1mCYr9cac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaJSbCPc; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaJSbCPc"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d18f80b5c2so4346530a34.3
        for <linux-modules@vger.kernel.org>; Wed, 18 Feb 2026 00:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771403368; x=1772008168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yQTXQYFav49jYyRtw64JUokHu/z2PFtLBgO8hXSnfbA=;
        b=SaJSbCPc9f0xYPHtJJM7TuG84/zwLQPcpFMiU9kdigeVitK6lmbcGGOBD0X/X2uriq
         Gl0ZVFEIxCY7X7SjIjAzsdVLuGXGk4R7+l0I7wJvSej6GDg1Q2afvgu57Npab3L/twvY
         lG7phEl1hmyjt5kl54WfORLCnPuYX41tDU4q+2wjv3EiJrtv5RBAXflm677aaaWNJBsl
         f7xYn9CdIv33zuls8amxN9+PYxFrVMM9HefvJw6pTZNU0xjHBXkRGQj8tedkNy/hdTIT
         BfRIHNKc/1sQGVdcKWhw8pfZ8sgFUxCdk4SryWLKdw/0b/3RLjWrL5cMb1LL2uln9t+X
         TBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771403368; x=1772008168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQTXQYFav49jYyRtw64JUokHu/z2PFtLBgO8hXSnfbA=;
        b=shZjChriCPXROKcN9bC3iAq5RIZXxcv+Qr0DdC9yqgtHxPE/FHw1zK9MF6cJh//L22
         RXC55nw0IPhC37ouWpOZElX6vsHaNKjG/dkJ8fQXOx3KLePvZYhFWcAjnvKdxbOs5gZ0
         XLaRQQyg9i5qNkQHV2I0lZNzdiXIn69F1M9E4OL9b2nKbUa3797ollBlk6Ht969tDgCG
         8b95F/WtjMmHltO09+EdQZoX7TePbCI9jVpfuu6tX+xAxL8ht8jSJiRnEfJhEESXnqj1
         kY2wzrEcpQVoXBWVWJjDGG4eRpsUnczgPZkt+sfAXf4fgxcPoIDkQW8Ipd9iFC+dHQ5p
         TZkg==
X-Forwarded-Encrypted: i=1; AJvYcCW4+JYN4yqA3iiBSwr8UNJU/2MgbIEVuDbxgXD4igb1NBzCcaFH1Om5Zv9LwKN7ySpA4/pewnsCGVFNtSBH@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWBKclHPqGP1FY72V3sG0O1145rZf2VAjdsuBbIqafBAmxEED
	miHXj+/JNKZ7PlVXkRxr1apOOtmyzwKmGKn+BGTkJshINvgV/mSFhzq4AHLh5g==
X-Gm-Gg: AZuq6aKFNA3d9wDiVrJVFcuVLHsT89R7ltCqwUqqiT34mcQlbcL27g+NaaP1KZargHF
	DuopvCM0+eRBl9yQLlCAKQL/TRTfCUBX0eHJLJQFWg4/3dVFoaOVnMx6xCVcPGFtHxc6I60Fjp2
	pSp2Hz2QNqrQMPb5M5w6N7w9RgXWXgyj/DAzBKYifQ7mdfgDVDpShNQP0Z/0pcKXpU/N/ldMyYV
	aupnepKrlLUvmQQ8adxHQjVIcxBqwk3JrXTC+2N/BO2DMOXTw5a/a/gsoFISFWCG/0bx7ukVRba
	Hic4qqVLm7L6zwMDkHd0SCIV7YIBZkhvXy3aIOZuYaTz0smgD0/mdjTB5MkRd25QqtUVyCR51q1
	0sHc0CxLDH/VF4TJx23tqlug9C27Rus3JxL1E0JXx21Ep+nSabtjf4MG3OXIT+u/RaKYR+tLqrR
	yU2M3oQ/u0/OmG2GrKo7gbzvzlDgz7ApafoI6ikpMp43Jl6grxnI1T4H1ch4g4jwk4
X-Received: by 2002:a05:7022:a88:b0:119:e569:fb9b with SMTP id a92af1059eb24-12759a00d27mr429509c88.10.1771397414519;
        Tue, 17 Feb 2026 22:50:14 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:968c:f102:3683:408a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742b62274sm23152120c88.3.2026.02.17.22.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 22:50:13 -0800 (PST)
Date: Tue, 17 Feb 2026 22:50:10 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Chris Li <sparse@chrisli.org>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, 
	Petr Pavlu <petr.pavlu@suse.com>, "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>, 
	Malcolm Priestley <tvboxspy@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 3/3] module: Add compile-time check for embedded NUL
 characters
Message-ID: <aZVhE90b6dZbGpfj@google.com>
References: <aThSGiKwJRYOB6kx@agluck-desk3>
 <aThqcq0iGge1pQCr@agluck-desk3>
 <20251210010020.GA2522829@google.com>
 <aTn0WdVv-S_EpQmS@agluck-desk3>
 <aTqAxfiVCR2ch4I5@stanley.mountain>
 <CABCJKufWw4VQA_k6Deuf5Bn6401cbYv_St8VV_0-LAau6F0nTw@mail.gmail.com>
 <083ebd92-4b3f-47f8-bf0f-395a604b5f05@kernel.org>
 <aUVI9smf2t7PvDF6@stanley.mountain>
 <aUV7kyjxlijuy5sC@agluck-desk3>
 <aV9vo7_turBr84bs@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV9vo7_turBr84bs@black.igk.intel.com>

On Thu, Jan 08, 2026 at 09:49:39AM +0100, Andy Shevchenko wrote:
> On Fri, Dec 19, 2025 at 08:21:39AM -0800, Luck, Tony wrote:
> > On Fri, Dec 19, 2025 at 03:45:42PM +0300, Dan Carpenter wrote:
> > > On Fri, Dec 12, 2025 at 02:30:48AM +0900, Daniel Gomez wrote:
> > > > Maybe the flag fix just needs to be applied to the evaluation? Other op
> > > > structs do the same. But Dan's patch did not implement evaluate. E.g.:
> > > > 
> > > > static struct symbol_op constant_p_op = {
> > > > 	.evaluate = evaluate_to_int_const_expr,
> > > > 	.expand = expand_constant_p
> > > > };
> > > 
> > > I was waiting for you to send this as a patch.  I can do it if you
> > > need me to.
> > 
> > Al Viro thought this was wrong. His alternative patch is here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/commit/?id=2634e39bf02697a18fece057208150362c985992
> 
> Sparse still is PITA as of today, can we get some fix (Al's or alternative)
> ASAP to be applied and sparse tagged as 0.6.5 so the distros will pack the
> new version, please?

Any update on this?

Thanks.

-- 
Dmitry
