Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A885253B73
	for <linux-modules@vger.kernel.org>; Thu, 13 Nov 2025 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002236; cv=none; b=r4ywWZ7fTGkdN6zvg58EyyYNjoobPuWprf+dIaSA5hNTYaYmEMNmg/LxrHJ3M17q/YItTsvaB9Ce5ojPkBmzgAnjpkGTcZLT0+F6j6FITnTmsw/PiGtVKzw37s5OVRPMUZNNOcRilfktEhWqM7m1FLZoTPjV7BgfbFo5OEBhUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002236; c=relaxed/simple;
	bh=1UywZ5EspbYYlW6xtPXW+5JF7MzvE+fk4ld2AVk511Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAJxF7oMovU+kmUnZ3ExU7N+Bn+3wHIPmIOheVbnLxPA9HZ1bWwQKT1nf6afcRl+djLI4wvwhvjf9SP1OGAPD29DNcbR2MuUEFcJ0bdMa76T5plCs8pGfPHsuRLb7xMjuoHkVctdYo/C18XmO/OQoU1sEJbCIBq7wQIpwTdzH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7/foJwi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7/foJwi"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-429c48e05aeso164087f8f.1
        for <linux-modules@vger.kernel.org>; Wed, 12 Nov 2025 18:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763002232; x=1763607032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UywZ5EspbYYlW6xtPXW+5JF7MzvE+fk4ld2AVk511Y=;
        b=A7/foJwih5tODU6mGE56M+xIRYocWBiG/pexRxN3jFMXT3bAERCE0iR2tVvnmJNPPv
         zqhOV+8gk2MU4zrJ3u6AcjImkwQjQL/V/TQqstpSF8eeCj2SjSDJ2ZWug+hQb90IrMVE
         ySH8bacZznHRMx6UULqycj+tOxEB21GmrHiEN7dsAVmYb5JPcAGlXjD5jeD3CguyLNnq
         8/yuElRV8rX4D76Yh/sGXTHuutKpGxqQPk+BrE5cp8UsuzyZpzt1tCkb7CL6jjDint21
         PUCbdNIrr9Yjq9HOCtdmub1ZNUK5uQ+bevYHj7m4UXpYDnm4YCOqQZHdKn3LzgG3tCYT
         coVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763002232; x=1763607032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UywZ5EspbYYlW6xtPXW+5JF7MzvE+fk4ld2AVk511Y=;
        b=gvKSvUAn5O/3drLPwnF0J7Yry4jSUFozfUxAI7iLzNP4xiVkd1cfu7IjBkmlvfxr/J
         MRGgqD0qd6zeBKGqpsAAtV09qaWXRMGNdDWAuu4u9n4DK4TsjdihEgluZfeSKF2elIEi
         oN9+4XOcAwJNXRMIntz7xPZhGRENzGlI4AXY/AArQx++6/uwCkMNiAPKe/mU4pn/KG+L
         Gyr47LR0dmh5ynS3RgRZjiBVmkj0OgAUBchBfgG1L1JJzB8j/lLnLlyv7t0g7sjBqHlq
         z6wU43SHk536GHgmYDT+e3YZSbdWcgn/3tJJLVViw8fWlTHtwG1SLT5WmmuCk491n79I
         xdMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNguejNmZuEDnPyXNMbB9bXxV87OXfbVRIK+2mbbw2FjiFmrKBLNJcTlcLRT5J9gkW/m50AExa7Jeddn7E@vger.kernel.org
X-Gm-Message-State: AOJu0YzGyZamAVUL0m7jtYEfDKinBd1iBEa5WD2JA+Z6lGdYs0L5EmmZ
	4XIEyrTNeLGvkH54kwxeM+bssUHlTUKO/RoTtDaS1FRl6ezhamZf5TNedd35R99VHu+RBM8DkY0
	VkLaoTqGEEs4Z182ScZuhRyWXnES1ARA=
X-Gm-Gg: ASbGncsWVS4avVkr+paeBoPBm+UFKhs7LLuOzwwcQcs2+O9wYvts1FP7LKmPpDzPUDm
	mSTidiST1dmu1Qs6rECtv10EOkIyngUi1Jd9jTGmQVeD3D0wcQx+0LrKgtMRtzXqsc8NpOJS5FR
	ABBCxjgQ5/DCcWhhW9DZFO6R+uoluxIP5gbCEE+O03bWMHFccae6DreldKtiJb+FISvVgzsN2bO
	NeL4EyOf+efDD/9fEGczud2K9mXjPL3ZLHvXbx5WLlLiHGMf7UyvDFy4z0zPgdWnFtkpcBSYcVN
	VEMQn3eWqvgLpXnsDg==
X-Google-Smtp-Source: AGHT+IEGxkHsLlDeqqKYYxVV4qPNOdwbtTL8tifx+l6rLgWuNnhOTSmN/RLFv9iuIJNS51+mPUGAeqeerVG2TSOJBiA=
X-Received: by 2002:a05:6000:4310:b0:429:bfbb:5dae with SMTP id
 ffacd0b85a97d-42b52814d8dmr1346241f8f.17.1763002232446; Wed, 12 Nov 2025
 18:50:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112142003.182062-1-pmladek@suse.com> <20251112142003.182062-6-pmladek@suse.com>
In-Reply-To: <20251112142003.182062-6-pmladek@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Nov 2025 18:50:21 -0800
X-Gm-Features: AWmQ_blTyug6l3_C6LlEH8I8hAO4t3AT5lTjYea505BxtYynZkMNHSFE3MVvFng
Message-ID: <CAADnVQKUffyGCmpoGcvSTF1hwN58c7X=Ebvn70Y2Z0ZWJS0p=g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] kallsyms/bpf: Rename __bpf_address_lookup() to bpf_address_lookup()
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-modules@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 6:21=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> bpf_address_lookup() has been used only in kallsyms_lookup_buildid().
> It was supposed to set @modname and @modbuildid when the symbol was
> in a module.
>
> But it always just cleared @modname because BPF symbols were never in
> a module. And it did not clear @modbuildid because the pointer was
> not passed.
>
> The wrapper is not longer needed. Both @modname and @modbuildid

is no longer

> are newly always initialized to NULL in kallsyms_lookup_buildid().

are now?

> Remove the wrapper and rename __bpf_address_lookup() to
> bpf_address_lookup() because this variant is used everywhere.
>
> Fixes: 9294523e3768 ("module: add printk formats to add module build ID t=
o stacktraces")
> Signed-off-by: Petr Mladek <pmladek@suse.com>

other than typos in the commit log it lgtm.

Acked-by: Alexei Starovoitov <ast@kernel.org>
