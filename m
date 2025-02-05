Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E48922A4C3
	for <linux-modules@vger.kernel.org>; Wed,  5 Feb 2025 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738744999; cv=none; b=pdnYQU6ukkh06T5X883wXKySVXiknrluyzhQqAOL1AO3Ap2mJwFWCK0wJQeiDxPj3GG1RXPoxYw0t1NrgyXqhFDvnDvIcGssMZ2FLDfNTRzsuyA9vgPifWqGQWqkBIz5c2TY+PuPiXhBkop33eNWVbjXex7sKYXo8E47bysboHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738744999; c=relaxed/simple;
	bh=p0ibE0imzJrzuTS00bOK/Id3Y9/SeHlbskz2XeE+f3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NvmAkn24SyI1mWYsJzqBUVrgizXNF+1q7oa++/IcxVhgoTR7kml5VVMW+WmntA44e8JKtOJln4rW3Odci28X9usBs/QUpZGjz6CKxv3VKrzZIdDwp5wyTG8aBFlKGXUsfg6avPNR805qsy6FM3MsLW8jgb+97GtH67pz1s9+N2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=ThTFi8Yr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ThTFi8Yr"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so6479677e87.0
        for <linux-modules@vger.kernel.org>; Wed, 05 Feb 2025 00:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1738744994; x=1739349794; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+e+hBHhv2/Q+FPnc04pk6OB54D2kTpJhA7pWv3JJQyA=;
        b=ThTFi8YrYfEMUaI4c7IGuw1Y25VaBiNgGzQPd98qMow4CYsBxh84hcryJ7I1r4DH0Q
         ve/WVmE8H3Qmd0p/FSAsEAK7jUVLQaiXPQgBtmOMVfemryyiRZaXkdqrgC9MLlz13Orv
         hn+TxMcCikftehseLaEQVsArzfDvBzKJ7Ahy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738744994; x=1739349794;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+e+hBHhv2/Q+FPnc04pk6OB54D2kTpJhA7pWv3JJQyA=;
        b=vhlNPXSCOJaA2iefQ0qynmxQ+dWrgkUl9Pfp/NnuK3EVACHSmh+8vobTHxnfhKqtYI
         reeUYFHyoMUOPoLtUn0r/S0k22ONhyZFH96D4JjcwSkp6fig8hNl7SuWeMXSW86FUl7q
         hWG/PbG2RRRcyB+3LN7Kc1jFsvwkqdueepT4Ma41JWbJfoBH4zme1QLhY259lsSWEcaH
         RwoLBIM3ZIMOHPNNq4oNXDHui6jpEtxTvKFWzP9Ei5JmNPj15lb/3Rak/g9pU5ywgkon
         dOTh41n0mZMnBNhEg/N4Yte3a28dunIbWOLIEnLMbVYIgSOUoP55UjSbUpnnmj1C+u0q
         zJLg==
X-Forwarded-Encrypted: i=1; AJvYcCULNde/3mRMnyWL6lUEQyzjNBtluFOnigfadDrIZ9U0TM67FzBbcjMoV9WH1/lpF8wb/W/tHHt4r/mQJiAK@vger.kernel.org
X-Gm-Message-State: AOJu0YyE8EovVeZYxLgVd4ftPEZqGHi3iTU9SdhVJofZSeW4IjnfvFlb
	YetWEKL1Tw9YDkObxoTEMUjBpRlH1xl/RL6DS5JyOEDIofvTTtqJMceOAAbzIfw=
X-Gm-Gg: ASbGncvWLqO6IEMbYMuNV0eW3HRW2WNIIXM/ti0VnA0oX378o3hA1ORr7hm8QxoCqRo
	G9hoKADtgb7GVHnww7yChIGPYr/W3Uo0kNHXTRz99x6jWFGVG9PI1y+5rZUcd+Isr528MqnXaFW
	Ujlj7PiDIE9D2jrQ1Teju1FacbYxo0xPvX3wK/58DSKJxuCGM2tIzF7PrkPxno/iEwu6pHkaYMr
	YB+78jLJyzOqhV6kN9JiTwxfhuKPDIP6mQfdxvCLLi5rugEYzr2uV7tGV7R/mxqHrvxlLgZh8dh
	2dgepovmuaywre8x
X-Google-Smtp-Source: AGHT+IGdeze+FGm6RJ6kK0EmlM0IzS1+jIlMHYzfJceotO2M3xr68jPPBD2PPXE1VqhcZHZypTYtiw==
X-Received: by 2002:a05:6512:ba4:b0:53d:dd02:7cc5 with SMTP id 2adb3069b0e04-544059fd016mr420040e87.7.1738744993888;
        Wed, 05 Feb 2025 00:43:13 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-543ebe15778sm1810443e87.104.2025.02.05.00.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 00:43:13 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,  linux-modules@vger.kernel.org,
  code@tyhicks.com,  mcgrof@kernel.org,  frkaya@linux.microsoft.com,
  vijayb@linux.microsoft.com,  petr.pavlu@suse.com,  linux@weissschuh.net,
  samitolvanen@google.com,  da.gomez@samsung.com,
  gregkh@linuxfoundation.org,  rafael@kernel.org,  dakr@kernel.org
Subject: Re: [v1 2/3] include: move
 lookup_or_create_module_kobject()/to_module* to module.h
In-Reply-To: <20250204052222.1611510-3-shyamsaini@linux.microsoft.com> (Shyam
	Saini's message of "Mon, 3 Feb 2025 21:22:21 -0800")
References: <20250204052222.1611510-1-shyamsaini@linux.microsoft.com>
	<20250204052222.1611510-3-shyamsaini@linux.microsoft.com>
Date: Wed, 05 Feb 2025 09:43:12 +0100
Message-ID: <87h658u6hr.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 03 2025, Shyam Saini <shyamsaini@linux.microsoft.com> wrote:

> Move the following to module.h to allow common usages:
>  - lookup_or_create_module_kobject()
>  - to_module_attr
>  - to_module_kobject
>
> This makes lookup_or_create_module_kobject() as inline.
>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>  include/linux/module.h | 39 +++++++++++++++++++++++++++++++++++++++
>  kernel/params.c        | 39 ---------------------------------------
>  2 files changed, 39 insertions(+), 39 deletions(-)
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 12f8a7d4fc1c..ba5f5e6c3927 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -894,8 +894,47 @@ static inline void *module_writable_address(struct module *mod, void *loc)
>  #endif /* CONFIG_MODULES */
>  
>  #ifdef CONFIG_SYSFS
> +/* sysfs output in /sys/modules/XYZ/parameters/ */
> +#define to_module_attr(n) container_of_const(n, struct module_attribute, attr)
> +#define to_module_kobject(n) container_of(n, struct module_kobject, kobj)
>  extern struct kset *module_kset;
>  extern const struct kobj_type module_ktype;
> +
> +static inline struct module_kobject * __init lookup_or_create_module_kobject(const char *name)

As others have said, this is way too big for an inline. Also, __init is
at best harmless (if it is indeed inlined into all callers), but if for
whatever reason the compiler decides to emit an OOL version, we
definitely do not want that in .init.text as we are now calling it from
non-init code.

> +{
> +	struct module_kobject *mk;
> +	struct kobject *kobj;
> +	int err;
> +
> +	kobj = kset_find_obj(module_kset, name);
> +	if (kobj) {
> +		mk = to_module_kobject(kobj);
> +	} else {
> +		mk = kzalloc(sizeof(struct module_kobject), GFP_KERNEL);
> +		BUG_ON(!mk);
> +

And while the BUG_ON() is borderline acceptable in the current,
only-used-during-init, state, that definitely must go away once the
function can be called from non-init code.

This is what I alluded to when I said that the function might need some
refactoring before module_add_driver can start using it.

I'd say that the BUG_ON can simply be removed and replaced by a return
NULL; an "impossible" error case that can already be hit by some of the
code below, so callers have to be prepared for it anyway. If the
allocation fails (during early boot or later), the allocator already
makes a lot of noise, so there's no reason to even do a WARN_ON, and
since it "only" affects certain /sys objects, it's probably better to
let the machine try to complete boot instead of killing it.

Also, I agree with the suggestion to drop/outdent the whole else{} branch by
changing the if() to do "return to_module_kobject(kobj);".

To summarize:

- refactor to do an early return

- drop BUG_ON, replace by return NULL.

- drop static and __init, perhaps change __init to __modinit (which is a
  pre-existing #define in params.c, so the function remains __init if
  !CONFIG_MODULES), add an appropriate declaration somewhere, and if you
  like, also do the rename

- make use of it from module_add_driver()

Rasmus
