Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437AC204F83
	for <linux-modules@vger.kernel.org>; Fri, 21 Feb 2025 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134548; cv=none; b=JtMMidk7tGvEQGhxlhkaV+lDAVH7E/etbJKU2ynWseNKnnVT4xa2T+TgASfrauK9NQCOFf7xb7ieORiYhvUmwUBRh5pQZzGKmdWe7wRiKMIhJLbKNyKlayueWHtVkpffVsv0C1h3WGZjaD5q919/dyCFt7WvskcLvmrb3Qa3Pew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134548; c=relaxed/simple;
	bh=0rcB3ubTo1BnhhOnFaFoIOmRH3QJYilM1Td7GL0JpRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=onCquen/8sY4FVVrZudPfd2tX6wToWZQLs+UQ7EEyxaoUS9kMiHICkJMFyVyONxiquQRTXaR+r/Kei2CqlawFCcd9AyLEHKb6ztsMgsY/j3H6/HXHWeK5F8GSNA/BoeGAniIYXRRkD3pXJZPX8x7fGUikKk+rXzq11pEBq5+GeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=WxnLwaaR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WxnLwaaR"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-545fed4642aso1968014e87.0
        for <linux-modules@vger.kernel.org>; Fri, 21 Feb 2025 02:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1740134544; x=1740739344; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NWetMDW2xb9Wc051AWYRPw/1wphgBRH9V7uhWv7WS1k=;
        b=WxnLwaaRyJmfuNVO2Z57I85baBP8ftEkaItg+Ohlo/0gICwKZqDZxbtKjE87ommona
         zE35ALubF09MrRJ6rjoJPhHgoptidpY/Ib28ioWfKsrN8LVUvtjA8+y0NyPWA/W7lVNp
         6LxYeUZiqt8om+V3qSMYupCsc0pbvTMACqwqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740134544; x=1740739344;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWetMDW2xb9Wc051AWYRPw/1wphgBRH9V7uhWv7WS1k=;
        b=vEgSe+lhKpOKvp+XBgiNDPjoWJjgAA4jKbOibd88Cs2iWm/EXt1qAszjOaCkvwyT86
         pXv+0hmRFVdTZPXX/yaIEMagl44UXvmgbiB2gWgdiPI9BmA+vO0JAgIbPyiVvoVm4Frf
         NqdB2W/VfdMNQgwv2aBD5GHT10Gb1ALuqOgp4s/I/9omjo/RChvhKEG43jkD4nJSEj7G
         qmSHJaVlKqj05JmPHZMtOeECTRg1HxrApjoahfmkYC9VEftxWbqRdP0pGx1Ofc1jHxcf
         ph6XhUrQ2/Fiz9BgsLv//PxoVfquRrMVBSrvjl3YnfFaQ5H8ai3fRzh90po40Qdnb5z0
         0peg==
X-Forwarded-Encrypted: i=1; AJvYcCXott76BpfpO67V45TAXn9PVhXar7Q+Rq2fGHWvE3kRIlZFsXvALvfZm5U2K2k5j7+yJ+VVZEX5YCpSCdl1@vger.kernel.org
X-Gm-Message-State: AOJu0YzDVXzbW84Ekinpi8RR1blIzeGW6IPjIWzeaqRFJgmvh9v2kv4m
	wF/yXmSnoE9nUY3mQ1l24u1il5EeJnl7bjXApjIGfmap2zhjqCgn0X94sokh1So=
X-Gm-Gg: ASbGncvpD3J5MSb6fO7O1cOsZCzcAYQ9bxRLP2GA1B3Fjv5fYrDeU5Xw51zYBCZT7VA
	Cvmq03fzzJLNGeTTeL0WK0nPByd0Pqf5SDHdTk8Z1e3GbpqwPJoqkozm70A4+yer5T+mxnfyHzj
	xbTjdw52X1Weop/NBsS2IV60X7/tOv+Gyyzn0agv0prNQOuL9DXd6lHrjHTaihQaa0HMQ0cskbX
	PyQv+5zsC43N0ST+hLod8hlBDIIbsCxDQ0KuflgbdNXnc4dhCKn/bhaDsvk3IndTjQXAh19Snqj
	+yPf7jsL3OpRxbEjSXX1E+uAQuc=
X-Google-Smtp-Source: AGHT+IG+PGWQKsOZJC26UWQUXP6A9M7GcX4VYUFqdHS2hS8V3seGLwHjv3Nmc5kastynZQeUnBglFg==
X-Received: by 2002:a05:6512:3f20:b0:545:2d80:a482 with SMTP id 2adb3069b0e04-54838d3d881mr865335e87.0.1740134544055;
        Fri, 21 Feb 2025 02:42:24 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-545d1b80f36sm1830410e87.227.2025.02.21.02.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:42:23 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
  linux-kernel@vger.kernel.org,  linux-modules@vger.kernel.org,
  code@tyhicks.com,  christophe.leroy@csgroup.eu,  hch@infradead.org,
  mcgrof@kernel.org,  frkaya@linux.microsoft.com,
  vijayb@linux.microsoft.com,  linux@weissschuh.net,
  samitolvanen@google.com,  da.gomez@samsung.com,
  gregkh@linuxfoundation.org,  rafael@kernel.org,  dakr@kernel.org
Subject: Re: [PATCH v3 2/4] kernel: refactor lookup_or_create_module_kobject()
In-Reply-To: <4039ec74-8b46-417e-ad71-eff22239b90f@suse.com> (Petr Pavlu's
	message of "Thu, 13 Feb 2025 16:55:54 +0100")
References: <20250211214842.1806521-1-shyamsaini@linux.microsoft.com>
	<20250211214842.1806521-3-shyamsaini@linux.microsoft.com>
	<4039ec74-8b46-417e-ad71-eff22239b90f@suse.com>
Date: Fri, 21 Feb 2025 11:42:22 +0100
Message-ID: <87wmdjo9yp.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 13 2025, Petr Pavlu <petr.pavlu@suse.com> wrote:

> On 2/11/25 22:48, Shyam Saini wrote:
>> In the unlikely event of the allocation failing, it is better to let
>> the machine boot with a not fully populated sysfs than to kill it with
>> this BUG_ON(). All callers are already prepared for
>> lookup_or_create_module_kobject() returning NULL.
>> 
>> This is also preparation for calling this function from non __init
>> code, where using BUG_ON for allocation failure handling is not
>> acceptable.
>
> I think some error reporting should be cleaned up here.
>
> The current situation is that locate_module_kobject() can fail in
> several cases and all these situations are loudly reported by the
> function, either by BUG_ON() or pr_crit(). Consistently with that, both
> its current callers version_sysfs_builtin() and kernel_add_sysfs_param()
> don't do any reporting if locate_module_kobject() fails; they simply
> return.
>
> The series seems to introduce two somewhat suboptimal cases.
>
> With this patch, when either version_sysfs_builtin() or
> kernel_add_sysfs_param() calls lookup_or_create_module_kobject() and it
> fails because of a potential kzalloc() error, the problem is silently
> ignored.
>

No, because (IIUC) when a basic allocation via kzalloc fails, the kernel
complains loudly already; there's no reason for every caller of
kmalloc() and friends to add their own pr_err("kmalloc failed"), that
just bloats the kernel .text.

> Similarly, in the patch #4, when module_add_driver() calls
> lookup_or_create_module_kobject() and the function fails, the problem
> may or may not be reported, depending on the error.
>
> I'd suggest something as follows:
> * Drop the pr_crit() reporting in lookup_or_create_module_kobject().

No, because that reports on something other than an allocation failing
(of course, it could be that the reason kobject_init_and_add or
sysfs_create_file failed was an allocation failure, but it could
also be something else), so reporting there is the right thing to do.

> * Have version_sysfs_builtin() and kernel_add_sysfs_param() log an error
>   when lookup_or_create_module_kobject() fails. Using BUG_ON() might be
>   appropriate, as that is already what is used in
>   kernel_add_sysfs_param()?

No, BUG_ON is almost never appropriate, and certainly not for something
which the machine can easily survice, albeit perhaps with some
functionality not available. That this had a BUG_ON is simply a
historical artefact, nothing more, and borderline acceptable as lazy
error handling in __init code, as small allocations during system init
simply don't fail (and if they did, the system would be unusable
anyway).

Rasmus
