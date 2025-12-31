Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EDC22301
	for <linux-modules@vger.kernel.org>; Wed, 31 Dec 2025 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767174391; cv=none; b=RnUCS4lNRe5E6aJV7YH6rz3ZWdam0qldlnRrdoCNDWbrogpUWLxPYa2aY+yMllafc0sDphsyTfLWe6CQ3iLA4G5P1aYTtAKwCgc/Z7qF8kBylnPaH4pxukyMScSMr/lRWpgnOrqXbfCNU/LYV/9uudjEY5dWufIDjsHSyRR1HYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767174391; c=relaxed/simple;
	bh=v4+kYISr+of4n459KnZqo4J1uHSJLdeHnZwJxh8giyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCDuUHrI/N7Xtipx0tnmK19A7WvnSfDe1IFTikQeBwDJgHG43buSelQZaENeGbKKdOhUdA7tHnTmIvi/QrbUQEITfvVuGRU30Syc+p8uDJjwa71+rXQYk42JT+1er1420akYNz6oZCdqPobxucaDxEOZ/T4blYaUfTdh+pZcwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeGDNXQw; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeGDNXQw"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64472ea7d18so7133980d50.2
        for <linux-modules@vger.kernel.org>; Wed, 31 Dec 2025 01:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767174388; x=1767779188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7CnRV/E8liYWJxh/G/cxUw+it4IdBSA7ygXeg1MQ8k=;
        b=AeGDNXQwOkYWxYC9qTZ04Juy9NNHVUHahCgfAjnrrS1nGFF79uB9eqVaOzQALRLOly
         B+ZtrPSyw4kEypFlPafp3HFIN/rdyeb55ukYl6K5BNcWGipVuwFSRqs3Cw69S3X1o1yg
         4tqM/SJlWFqK8uCtO94ESP5JAxGCAylYk+U3vuPlM211swRa3RZaOQ94AlgQcQZWadSZ
         eVKpueZOvTjRztsEHi9L8lU6rToPWlFlKcAPbEmRhaDG0aeaQaqoDS378UFhMm4Afzxv
         77fDOa9dJy/dmAHM6SmgyTgJ89n5XsubEAPNpJvkKVZnH641yj5twtO6SD5dVv1R+Uva
         mxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767174388; x=1767779188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7CnRV/E8liYWJxh/G/cxUw+it4IdBSA7ygXeg1MQ8k=;
        b=a7TfmaptFzcyx80cuZlImSjGMeStwUZckPf3eesKsiGMUlledQGzB//f+dnZYmOlPJ
         F1/13wOTyu5hElEk7MC5lqwDU2hSPd1sCc9meZ1cjmvHFu0WVEF6ly8D9fA0BGFsAv+W
         kULb180SN5L7yEqtym5SgEBpB2hOG9TN9mIrn+1BIj1CZpXmNSV3m+V8ENb5DL1DCc9F
         ry8n7sWTPS1Q/7CWExoQ0oLufeQCfLp7ACPhUMU+Opb1/CGaKCYjg+TSPMU0HFjQv33u
         LAMYtqBJa+fGqmLJMp0aPA/O//VP2Zusya/FHgjfzn1PPb0gRlrk0u/6F+uctatOCkqp
         6i0A==
X-Forwarded-Encrypted: i=1; AJvYcCXylBqjcOTjh/VSp2PJO/z66YNEFXdk9rxdX+goRJ91bf4bB4iFctAbBTMvLx0T+dFWlAwud2ctOaTPcoSI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8PxioKfOExbMGnH1FGT8L+ACRv1YVaHgED67xjsmQwJBlqCsu
	PqsWUmOl3wgtVx3GUZdFjIiq8ia6MvU5p/owBPjsHvK27omJ0JT2qt6+qyIqGTGrbcnJuKseU+q
	GUoB9/Rx8GvGK+mOod/ys/MWnE4o5VMY=
X-Gm-Gg: AY/fxX4P4GQ2JitoceYYdGi+rrUQwzY/8tmcoeuAbN1iPqmIWPl+dSAFrmSOamwwZeO
	a+LOis3fdFzs4l/MY2l2o/JYXr5Eixfkf1MMh2dIIE3xdj3Qj+14iXNBUmHfvEfFKn3Z9Rb+yl1
	xAJPdYYovrfuFe3YSPaH47FFeoq+auuKycR2qzfNzRmtTcyFlEkJHVfDMXzyXGvodNQFpzThINV
	+C3L8F1YK2rOrrT+l5XUpXs0e7+T1xw+dpxSwqufg732qFeAREwMpgbDv9nZaOENaEfsexb
X-Google-Smtp-Source: AGHT+IGnWHCUGpcf1wc9vVncB3l/UGN3eL830fJOI5xl7+b9Z4xjEF8kugVNQ0ekiSW1ZHuaC7Kpw8osreSY6HCxuZQ=
X-Received: by 2002:a53:b5c6:0:b0:645:561a:4c68 with SMTP id
 956f58d0204a3-6466a8ba605mr21246106d50.66.1767174388384; Wed, 31 Dec 2025
 01:46:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229024556.25946-1-laoar.shao@gmail.com> <971b1fd7-5702-4cf7-ba84-aedde0296449@suse.com>
 <CALOAHbBF_Q02amBXKh_iGPepp_-CbF91a-HAXa3pSnO4qBnX4Q@mail.gmail.com> <ydmepfnm647kpwuiv5a4grvvdmuntcmxknowa3nf6hnx4unlj5@5ne25xb7e46k>
In-Reply-To: <ydmepfnm647kpwuiv5a4grvvdmuntcmxknowa3nf6hnx4unlj5@5ne25xb7e46k>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 31 Dec 2025 17:45:52 +0800
X-Gm-Features: AQt7F2pMw5UW8Cg3s8lZ-AQawMAD1D5QGsyiERo8LCMdPLk_w78Jkp0uhyvbNg8
Message-ID: <CALOAHbDC8Ek5huH=cOMrwjJgzgyTR+1_RGx748NLPAneGYmdHg@mail.gmail.com>
Subject: Re: [PATCH] module: show module version directly in print_modules()
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, mcgrof@kernel.org, da.gomez@kernel.org, 
	samitolvanen@google.com, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 12:10=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.com>=
 wrote:
>
> On Tue, Dec 30, 2025 at 10:12:09PM +0800, Yafang Shao wrote:
> > > As mentioned, most in-tree modules do not specify an explicit version=
,
> > > so in terms of bloating the information about loaded modules, the pat=
ch
> > > should have minimal impact in practice. Alternatively, the version
> > > information could be printed only for external modules.
> >
> > Good suggestion.
> > I believe it=E2=80=99s sufficient to print only for external modules.
> >
> > Does the following change look good to you?
> >
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3901,7 +3901,10 @@ void print_modules(void)
> >         list_for_each_entry_rcu(mod, &modules, list) {
> >                 if (mod->state =3D=3D MODULE_STATE_UNFORMED)
> >                         continue;
> > -               pr_cont(" %s%s", mod->name, module_flags(mod, buf, true=
));
> > +               pr_cont(" %s", mod->name);
> > +               if (mod->version && test_bit(TAINT_OOT_MUDLE, &mod->tai=
nts))
> > +                       pr_cont("-%s", mod->version);
> > +               pr_cont("%s", module_flags(mod, buf, true));
> >         }
> >
> >         print_unloaded_tainted_modules();
> >
>
> Hi Yafang,
>
>
> This refined approach is significantly more palatable and addresses the
> primary concerns regarding log bloat. By gating the version output behind
> the TAINT_OOT_MODULE bit, we strike an excellent balance between
> operational necessity and kernel log cleanliness.
>
> From a maintenance perspective, this is a much "tidier" solution. In-tree
> modules are tied to the specific kernel version already, so printing thei=
r
> versions is redundant. However, for external drivers (like proprietary
> networking or GPU stacks), the version is the single most critical piece =
of
> metadata for triage.
>
> The logic is sound, though there is a minor typo in the bit name that wil=
l
> cause a build failure. Here is the corrected implementation:
>
> @@ -3901,7 +3901,10 @@ void print_modules(void)
>         list_for_each_entry_rcu(mod, &modules, list) {
>                 if (mod->state =3D=3D MODULE_STATE_UNFORMED)
>                         continue;
> -               pr_cont(" %s%s", mod->name, module_flags(mod, buf, true))=
;
> +               pr_cont(" %s", mod->name);
> +               /* Only append version for out-of-tree modules */
> +               if (mod->version && test_bit(TAINT_OOT_MODULE, &mod->tain=
ts))
> +                       pr_cont("-%s", mod->version);
> +               pr_cont("%s", module_flags(mod, buf, true));
>         }
>
>         print_unloaded_tainted_modules();
>
>
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

Thanks for your review.
v2 is sent: https://lore.kernel.org/linux-modules/20251231094004.37851-1-la=
oar.shao@gmail.com/


--=20
Regards
Yafang
