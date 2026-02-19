Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC934B1A1
	for <linux-modules@vger.kernel.org>; Thu, 19 Feb 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520682; cv=pass; b=IfxjXJ2HU8oOLNX1j9oreFn028DhW72aKavAZM2mF0fP2t5XuoRjGh84CxqS0+Gq+q2+2jtHQRSTaSPO3jDhqbMNYLF7XiRXgXLtFZ7heSANWwhg2P1n8CqAVDnrk5nVJIjZVujKI/CcDlGZtIhP8LzyepLzjEQL02Q7UzRhYVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520682; c=relaxed/simple;
	bh=b6U1hG3nrOVFz0ecG5N+39M6HPtyrPXlR9zj9WH7HqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qV8IPsn49znt39o0CUGGtbE9T++E+8bzTig4M8EWikjNrwxGm217ROUfhQmSn9dxwmbZ+ILEoRZa4De4cDIbLasCDaLH8h3XPq7q6GDbzINsdIljgdALy9hSBoKIwA1pAy9EDRSMOfYTy7OXu2zCNXDlFSDlwAJqgun0p6THPsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64aefa98fe6so1164746d50.1
        for <linux-modules@vger.kernel.org>; Thu, 19 Feb 2026 09:04:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771520680; cv=none;
        d=google.com; s=arc-20240605;
        b=Ka4LTsbEbN1yTZQnPdUl9ObWVWghVALUTPI3/OZUP+/vNMmZhAxGySyy8xaW1f4odA
         kGvQ/ac2oNevNmhmIyNYtAiHxAah8e1QRhAPY+NvIuPniheKBvdnmV+OYKACLqqSn9Ji
         i3FZ8Avy3HOM6Q1ms47J3Gslk70FA6iDtswGJPVjH/N/N09mXOkBfrtTanhfxrsUmSma
         xVvujXs2JVqHJHNRm/3C6VkNjmyx+7liRaHQzExaw52rMzVf/VAoRdF3/KYK9qnOitaz
         khSva/Cb0WIMdZv54O4kN2lR1RtRr+Fm6xIlV9aFEbZykrsA2AfS2waswkRve1y4Yo+1
         VTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=GCfnfADMenCdj35GVzlSj1RLfLETxBVqx3iNQnVeu6I=;
        fh=M8UN6B0GNSa2hZkiQUDNlhVQCVecb/1qPCcPd+kCGgw=;
        b=S7BukNns8tmRISjVDe12YYlQFLIBebpEG8RjnJe7cft6bhdmlzlN5GML8gN2IHbnM8
         UxzcmeFlgx8Wb4l59Y/swuSVY2oSVQ+aWSBlS6bTpCtTj3/ivLiIC022AgLTAOlQbSxO
         L5G1nNbD9Hd8qvF2tANVC/9/delWAO/STre7sVrox6L326K0pRY29MRdCH5OhYdeMcMJ
         P/wD31vK8H/Q9IOWb2GdvDRgc/xZbsYOTFG11pQrOb7pSOl9D9rEdwd0ZX2qzAZkX3vC
         GgJpkPXHpHKGH7/M6QwKOt3DvKjsMfk5yv/IhK8A0k/gnvbpknnt4DfIiSQC+StWmmxp
         zWQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771520680; x=1772125480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GCfnfADMenCdj35GVzlSj1RLfLETxBVqx3iNQnVeu6I=;
        b=tXj7XfEcF8cd/HjqUlr4+WWNGezu4OK1imu/5XECOZfK9/D8ShTJySTuqjCSE+eZYj
         1/45hjhAfSV3ASQ1ZGwqrcWCiJtDAJUxoWfEan+Z6uGON1c51RtTyfUnszV/rA4pAUhY
         iN/Rlm1RmBiQFjNfV/qz609A5G1GNrpvPNF27sXJ74YrGfTvArUW3axs+uxAHSaLJPir
         HHOf+WkjZXsU17n+xZRZ+Jtn8NUJs7UdERS7+RgYKROrPkSkk2F7cU1CZ0dUaqpA+GdT
         4oJGgKAkwupqANH64CvWRaoHTEix7xDf3KDpfGAfVkykJQYRg+7EczJuMvi03NXcYjPM
         yolg==
X-Forwarded-Encrypted: i=1; AJvYcCU/hicprP65kpsdYrz2Oam8rHZQwrO3wI6kB98E+QV6bqC8QIyTRLT17t7GPxiQuAdK3iKqo6yw9SRm2UPK@vger.kernel.org
X-Gm-Message-State: AOJu0YxJbjWt9X1EI8VfitdsJgvbxnpcckZNW/Je07FEqUAGChVqCSus
	utNrn809IrRkivHzQOVp5UmEhPVdI7J8vf68umV+uPVf/Zz0OSocQBS4alqm8Ci5f7oV6qTofud
	U5ZE9EbxXwIflCR9EVmoHo2hL3Y85ArkXzXubpHsMtQ==
X-Gm-Gg: AZuq6aJsxh2F9TfJb8AlXQEPUN9aM2npDq1ORl9NWKnzr68kdxqSaECN04O9GL+xVTQ
	ft+/BEk979qEGUI/6VVJtwKwZ42Xf1VBFqccqGsx8mz9Rb9q4lm2+zKHxlCF+ga1CYKkXWWE6lb
	d5qPa1kuYZlEzK3s9/IlmMD07z2Of03p21PEJFbuqnM8rqMpkeaiMslzSBMozidXS0RAzH1YHiD
	3bpx+xgo0Msk164e19S7TwImBaF5Whcm7UXp+kprI1atpwbnmFWpUskHp/P0ll1jQWd9zeVhMUw
	1hLyefXudv6LcycGYUKYjWBa6O2r/khv5XPcHKVslTIbJiA9
X-Received: by 2002:a05:690e:1c1c:b0:649:c375:974c with SMTP id
 956f58d0204a3-64c55587d75mr4376174d50.28.1771520680340; Thu, 19 Feb 2026
 09:04:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d3dd8fc8-ab46-4cf1-87a9-0324685ba2e0@kernel.org>
 <SJ1PR11MB6083C6D97484ED4E4710268EFCA3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <aThSGiKwJRYOB6kx@agluck-desk3> <aThqcq0iGge1pQCr@agluck-desk3>
 <20251210010020.GA2522829@google.com> <aTn0WdVv-S_EpQmS@agluck-desk3>
 <aTqAxfiVCR2ch4I5@stanley.mountain> <CABCJKufWw4VQA_k6Deuf5Bn6401cbYv_St8VV_0-LAau6F0nTw@mail.gmail.com>
 <083ebd92-4b3f-47f8-bf0f-395a604b5f05@kernel.org> <aUVI9smf2t7PvDF6@stanley.mountain>
 <aUV7kyjxlijuy5sC@agluck-desk3>
In-Reply-To: <aUV7kyjxlijuy5sC@agluck-desk3>
From: Chris Li <sparse@chrisli.org>
Date: Thu, 19 Feb 2026 09:04:29 -0800
X-Gm-Features: AZwV_QgEIU-5ticNLcegsMRlOq6nRWIo8xAridFdMNrLj6Suwr-SXxpNMC8DPy0
Message-ID: <CACePvbVCwr2hc+gqUBWz++GKsk6+c97sBrVRFJ015jyeLkDbcw@mail.gmail.com>
Subject: Re: [PATCH 3/3] module: Add compile-time check for embedded NUL characters
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, 
	Petr Pavlu <petr.pavlu@suse.com>, 
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>, Malcolm Priestley <tvboxspy@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

Sorry for the late reply.

On Fri, Dec 19, 2025 at 8:21=E2=80=AFAM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> On Fri, Dec 19, 2025 at 03:45:42PM +0300, Dan Carpenter wrote:
> > On Fri, Dec 12, 2025 at 02:30:48AM +0900, Daniel Gomez wrote:
> > > Maybe the flag fix just needs to be applied to the evaluation? Other =
op
> > > structs do the same. But Dan's patch did not implement evaluate. E.g.=
:
> > >
> > > static struct symbol_op constant_p_op =3D {
> > >     .evaluate =3D evaluate_to_int_const_expr,
> > >     .expand =3D expand_constant_p
> > > };
> > >
> >
> > I was waiting for you to send this as a patch.  I can do it if you
> > need me to.
>
> Dan,
>
> Al Viro thought this was wrong. His alternative patch is here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/commit/?i=
d=3D2634e39bf02697a18fece057208150362c985992

Hi Al, should I pull from your git repo
https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/
instead? I saw there is more than one commit. I assume it is ready to
pull. Please let me know if I shouldn't.

Thanks

Chris
