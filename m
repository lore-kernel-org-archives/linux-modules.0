Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA51C701F
	for <linux-modules@vger.kernel.org>; Fri,  5 Sep 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085815; cv=none; b=MnVdHkkPsNyNWVL6hmfOzWt/rBsTb3fK07muImhpa+sq/O+lbR7vK/vi7t3EivYMDhbKWd6HsnZuzZgUqZBuRgfCN+Xx5fhO5oCm0uh/c/lFb3sHYIVA2MwCk8IzCUytGvOwb6+SaOW/5uiTcK6ujbN6S7EduKgkdtOzbHQFjKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085815; c=relaxed/simple;
	bh=L1erzjAPTsvN6HrQUgZX1AksS89vYp7mpiVFM99jDHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5XmJ864ZYOzz99LZzC7sgTyWkfF/WiEoURxcS7wlynIvWDd232VOeyRThDBV3daeMt+ViuFQOo7PjEs+nicJbOEBArRlf7hAyOVnIqTWPHXIaX+XxJbdMMFgUQIyMiq6HrZ38PBhPPKzjrjUUplQCc5h/Kdwda23qhY5G2on98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w75D6bIc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w75D6bIc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24cca557085so171985ad.1
        for <linux-modules@vger.kernel.org>; Fri, 05 Sep 2025 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757085813; x=1757690613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcbfPqu6x/zD1qFEIta6ywBnIMx01Wx5kGVGKOgI10Q=;
        b=w75D6bIc1c1N3id6E/MrxMCi44TcmoQ4KzC9Q+5DjUjdC+3ejvZBvxgxeXzf9yub58
         LpWDByLVWpKucH+tHgg1Aejq+CKc4QzgD61u/Azju2aBmk/+P52M2UcL7mRdEz0w/qwC
         ZFFW3v8Ps31X2Ca2lNLXyZtoqppJzggWWgO1L24UTkg0w55MOzUyZ3ThUZARuVkhWvrw
         4hHTMa1nc8qumSbrCzQuxB+PKchECfBg+wwZ1yu0E9FVRRr8ElFmMKQu3MsPUnpzwvu9
         p2viGewlJAAjOJVXl0sH0vJ02S1o/5+stC1LLHXN/+62zR1udO1ZVhFw57Pv59g7qD9C
         HdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085813; x=1757690613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcbfPqu6x/zD1qFEIta6ywBnIMx01Wx5kGVGKOgI10Q=;
        b=WiDchYM0Um0ZUY7CtksRnJA/4amDNjKmQDUc7p/sOkkaZp8S1g7a3iiFprNHAhdYki
         mW4sdSKgmjRd2IIDtcFxdFFIgVHM2C+scgjHtgm4kuSWnW05S9m3Pp2JH28mGY/s1xqh
         6jpgz/XyYOgILwsniZSrLGEAPLRIJ2tbDhIGqagIBDyXnGxlz/gBuU4HgViY21ZFzQyx
         2s2r0Pi67CdAoDerWYQZhdzAd+do9e7lr5kAhZ21z3qnqYwMKhOQcMesxcQ/pF5Peaom
         HcHYXMDWpA8aE9z/altXqGCIFga5V46lSQgKii0jSlJS3gcy+Msyoy+rmyBMWIoG9hrV
         0XqQ==
X-Gm-Message-State: AOJu0YzMhLCPkAiIq2zhYZr4FcqfQ4KhMqTMult0mUgEBYpD9T6WdQtz
	+Ps5E3bUC7W8T3llh37AZ28LUCV/Fe5fvdc3uEldakOh6BhO08HYixMB2X56Wj1Ge1Ju9FnU7/h
	y8yHdIjmu4jBJiR7ez6rvzO3Wjxe6qd1pQ44tJhP3TV87Hk9Up9zmeriJ
X-Gm-Gg: ASbGncumRQHUsdqOZaI60vQgSnTRZNPFwjGC4FeWyeSsBkhdVDW4nr4ar6ug+HpUCLD
	Q7NyPU93KXcpwpJhfB2f1BALtX1+zQVRzyeW/xhpoGf7CaZjPrj167vEOHMB7tKC6hVimCBEQJn
	5G8+Bavs2IPB/JerG1V41+sVMpjXiFfPtsg2qtYIeu5DmD4PjkzkANrRTry3SMEjtWU6HK+byFH
	Q0hm4e9IC17OYBj2Loyjw==
X-Google-Smtp-Source: AGHT+IF+gru6sdcU5F/mZuVq6IDva+6mmYWp6nBgVWHn+CRMCzQ/MCa/gCpzt0iDhfTf3m3/Un6Um48mI6lY8WAjZT0=
X-Received: by 2002:a17:902:f542:b0:249:2f1e:5d14 with SMTP id
 d9443c01a7336-24d3838da76mr2885585ad.3.1757085813071; Fri, 05 Sep 2025
 08:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE5b5zgXZ8UGEo_oOKGUqyWPOSfA9nBJw0_wzxRvEQZTjt6DLw@mail.gmail.com>
In-Reply-To: <CAE5b5zgXZ8UGEo_oOKGUqyWPOSfA9nBJw0_wzxRvEQZTjt6DLw@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 5 Sep 2025 08:22:56 -0700
X-Gm-Features: Ac12FXxckOMEebGfc8qDQJVkw74dP6APBx_zFnjXFuf9ojwwcEcU74MrYLbV8qI
Message-ID: <CABCJKuePtd00h3Z57Nj6TbG=GyeKeFgkzUBZJUT1v2_BQ9dczA@mail.gmail.com>
Subject: Re: [PATCH] module: harden module signature checking
To: Coder <rootuserhere@gmail.com>
Cc: linux-modules@vger.kernel.org, mcgrof@kernel.org, 
	"petr.pavlu@suse.com" <petr.pavlu@suse.com>, da.gomez@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 5, 2025 at 6:38=E2=80=AFAM Coder <rootuserhere@gmail.com> wrote=
:
>
> From: Fidal Palamparambil <rootuserhere@gmail.com>
> Date: Fri, 5 Sep 2025 17:16:01 +0400
> Subject: [PATCH] module: harden module signature checking
> Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, samitolv=
anen@google.com, linux-kernel@vger.kernel.org
>
> module: harden module signature checking
>
> This patch makes small defensive and style improvements to the
> module signature checker:
>
>  - avoid void * arithmetic by casting module header to const u8 *
>  - add an explicit bounds check for ms.sig_len before using it
>  - restore info->len to its original value when verification fails so
>    the loader does not observe a truncated length unexpectedly
>  - use READ_ONCE/WRITE_ONCE for sig_enforce to avoid rare SMP visibility
>    races
>
> These changes are intended to improve clarity and robustness; they do not
> change the signature verification policy or behavior.
>
> Signed-off-by: Fidal Palamparambil <rootuserhere@gmail.com>
>
> ---
>
> diff --git a/kernel/module-signing.c b/kernel/module-signing.c
> index abcdef1..1234567 100644
> --- a/kernel/module-signing.c
> +++ b/kernel/module-signing.c

We used to have kernel/module_signing.c before v5.19, but I'm not sure
if kernel/module-signing.c has ever existed. How exactly did you
generate this patch?

Sami
