Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89B4779B3
	for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125835; cv=pass; b=jksH+1UJVnegP0l7M/9nnrTd7e164Py25XXBkZqATq7xsoVdCkbu0YATi/tvqzOLMRv4XxDTd1umrm/DcBbAe+wiPdeB5JJGIZCN0gb3NIqBXXGEemodghQduuY9pvszQWGZSqbjBh7D2l+QJxnbLpW8ami+5/ke1SCy8NYWbJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125835; c=relaxed/simple;
	bh=jrvS32sEevys8TZH3O55MR1p10eVSCxD3OnQbjCZDD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2EqhOu+H3exdV+9ErvDfTAwz0Q83ExwV5NhbYY1FCcJZI7wHwmYGXfHu7q0mc32yYQGePu90pFU4vlCUuHuwtov/41GEd43g+mdQvF3tJEH7J/GIWptdcmkeXm/uXncVBRuQ309RjKEGJ+n4uR/rgGXLMTpQvBFw9UEu/0rPME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHQ+EcpW; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHQ+EcpW"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-303c0a57d55so158363eec.1
        for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 10:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779125833; cv=none;
        d=google.com; s=arc-20240605;
        b=OVAXLLnqas7INROmrgPhhBJS6VFUFWgys5wmPiO6ys/Kcjso6tz+ENd2LLimS8Z4xg
         LbmbkHs5OCbhttYcaLwfxMJczx6tU73jD/yyx4eNwJLsgvfwHj4Vkqvoe/UQis7fboDS
         HCHm3n4puuIvM/6zIicouebRLIzVRRP1QzbsMKVhouuG8+m1ybGr+p2yIdEPYfM8wKv1
         AWWpWHYMlU/EF3QnO7v0SJ8vplXp+fDxHiRkT8maZ6N8lKdw6GXCvo0QRqasFy7n8eXO
         CcnBfhSUwUPbhzUOI628fMxdCRwp55hvidv47wzKtc3mmr1YGQLWZe0XcSRz5vRJDPPs
         uYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0HX17qVGSDXSzZemTKi2JBGH3uqyvO3ppEnIs5HIR9k=;
        fh=Akoys0l1vt8UNaWk/zabT4gwCqcXszEmqYb0gZJIWnI=;
        b=L3juZIGaa2qHrHDU1TB/4Y1huhynGhiUFf6rlJGh42YD3S8aOmBRYgQocTtp4nUgzn
         wsnPh9mm2A4oJvtgYFwOHbse1AyxDzswDu//QA9GB+5xovoIVLX3oxBnlHiqmuaQToul
         ZNbR88BDFHZ/CleaU562ZuLs0MkCpsjosnLWthjIkM1yowbCGotXRbo7tsALBKTkVVSc
         1uhcjBzfIXKEMbmFQpO6U2z/qeQsGtGJ7XK7npA/YlT7CvO/MUy6xagAHGhPqiqmQFB4
         sOtQKp1Z9R9B1Y0QTK0qbojb3X5FGhxar19GXMJwnJZ+SGpOicAOikK2UzFckrqQpl4f
         a/mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779125833; x=1779730633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HX17qVGSDXSzZemTKi2JBGH3uqyvO3ppEnIs5HIR9k=;
        b=NHQ+EcpWGNxiHmV9+2TWO8suq1XSW+ehIxJ163fs2OzSZ8zdlHGjLruVBN/60iDZpd
         r7AwoisPfEzj5ePtUZAliNxEeEYkqlkTJBp+WunoByA4bgkmHma7EXGB2YIRU/Bicn2M
         TxORW1baGxevNuryYmdmN+vgzbp076coYe9FxyLhctlRTjxxDRi+LwWBuFR6luEzk2ZF
         ova3qthuxMqhRkdU3taz+CPN9VqU3Xt7WntLSNDem6rzwC1JUuoh6ftExDIg1d0+nF7i
         WmMHqQ4D/ii/QYSIvlDmI+mVGDjFfg1s6DqgIQ5mym3mO/UxDo29jcHFi8HqO9b2Fhzp
         w2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125833; x=1779730633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0HX17qVGSDXSzZemTKi2JBGH3uqyvO3ppEnIs5HIR9k=;
        b=QJlIrTTfBzCnJ/S5eFhpAy70wXXc3siTS9G1+CO5wtClJ5lvX6vHKsyvdNh1+gDggv
         SDyqbZih/JtTvPhvDpCxRM8tOGT/n2BXgQqbFdTC3jTYI205EO3rwIiMdO5csNZQuohQ
         dPqTtKKLmjWGVBR9E6/Y+/otUciVnNZKEJDj3sQOl7ItjIZ6Iy/ij8R1WfR1bQKs0mP+
         l+zHdVXtOrG7K8aDzfbccYMYL1YVy6OC4x+z3gPdBktFMmZ2BtpPIT+klOMccaiCinYw
         ARW081jlE/uFXqCi8eXmyBszHnAmtWpSc2lPbYFc8MTXQ2JUknV7CB/CSt1pONMHolKw
         iHpg==
X-Forwarded-Encrypted: i=1; AFNElJ/2bul45FT91OLePtW9+sLNHpsp7SigMCDahbfPxhh1fMYfHZE1f8V0XOIWsMajQNWl0ppZYjxrO2hLV+hm@vger.kernel.org
X-Gm-Message-State: AOJu0YyKR5HmrF8jHEDJUTCRlmIabgo+bUHf+GK5Cd36Ja3TIZAUJRPC
	MSue2cfs/SEkkBe2XaCh3BlNsXG8YN3LpTOate3B5DlcRYVoKhuYll62vMMD0cay7K3lNp8CpK9
	iDJZm1Hw1y+eh4TCQn0jFAI/5TpoxTfI=
X-Gm-Gg: Acq92OHm6P0w/wZFVlyM2cieJn5lD9d4dLChiprqEKu31rGml5gvRdiC2CxZW2nm7+S
	DHJoftwfkmgyRuN9UXXskqPs0A7WWfFzcJIav6dd+xB0VlARw7FbZAYD2+gO12vDMWCdMJno4g2
	Tn7DRCYmaQRP8gsQCq+YNghl9C7+IwtcHMklYmRM0XEvgChB2wSsJEzkgbTEN/XSA7s5zx/+Cs0
	wh4OBdlXjUzgd6qr4fD2Jcc6bOj+G45FNzDLGgyLv8l7F6N5TCymPIBDs0u+ctEXIsJ1w4WmWPp
	izLTkr8Eltg8oUoP/0kQZw+wnF1E17oPgj/F1LOvoQ00/rTzANRspM4PctUTKhzuizXD0nCFde/
	8h4tXHpmU36kG7KD8O7C6Mk0=
X-Received: by 2002:a05:7300:2391:b0:2da:b05a:5a7d with SMTP id
 5a478bee46e88-30397c12731mr2821874eec.0.1779125833139; Mon, 18 May 2026
 10:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518134107.4114-1-cppcoffee@gmail.com>
In-Reply-To: <20260518134107.4114-1-cppcoffee@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 May 2026 19:37:01 +0200
X-Gm-Features: AVHnY4IEBcW_Q34oou59uRlgX_xaMFEhRhkXWKkbxl7ggzI2sZKcR1sOQptVmvE
Message-ID: <CANiq72kyRjidJ=s2CHgoP75cJ3yVZtmEFyraBocjkLUuU3+xPA@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: module_param: replace pr_warn with pr_warn_once
To: Xiaobo Liu <cppcoffee@gmail.com>, Adarsh Das <adarshdas950@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mcgrof@kernel.org, petr.pavlu@suse.com, 
	da.gomez@kernel.org, samitolvanen@google.com, atomlin@atomlin.com, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 3:41=E2=80=AFPM Xiaobo Liu <cppcoffee@gmail.com> wr=
ote:
>
> Replace pr_warn!() with pr_warn_once!() in module_param::set_param() to
> avoid flooding the kernel log when a null pointer is repeatedly passed.
>
> The original code had a TODO comment noting that pr_warn_once should be
> used once available. Since pr_warn_once!() is now available, switch to it
> and update the comment accordingly.
>
> Signed-off-by: Xiaobo Liu <cppcoffee@gmail.com>

Isn't this

  https://lore.kernel.org/rust-for-linux/20260226120848.82891-3-adarshdas95=
0@gmail.com/

and this:

  https://lore.kernel.org/rust-for-linux/20260427-params-pr-once-v1-1-3a8c6=
4704cc4@kernel.org/

? Cc'ing the authors of both. I will reply in the second one too.

(Also, your email seems to have been sent twice to the list)

In any case, Sashiko is correct, this "time-based comment" is not very usef=
ul:

> +        // `pr_warn_once` is already available, use it.

Cheers,
Miguel
