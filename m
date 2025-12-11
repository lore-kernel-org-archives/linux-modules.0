Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C72D373F
	for <linux-modules@vger.kernel.org>; Thu, 11 Dec 2025 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765472623; cv=pass; b=Cfwkwx1DCI6W+kZ3LQLUDS3dUbk3HP22ZDRy9v/95mqnAs1f8FPW0u8zEwFfAqR7lcjy4VgzPAO8xajzk/vjx2qViVZDjR7Wim3rxO3YOvZhkm5Zn7MrMRyAyGMDg2a008S0L+EJZ8n/hAmPZYpr6OkplNYWPMdKp5Cnvs2Bwnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765472623; c=relaxed/simple;
	bh=dhK4Q7kDIu3zi/kAqk5vEc3dRn/z99FEvKqsdSQw3vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6lgRcnkXyiCQAwO/b37/sB7npgW9nm7I/m4AjsrHZHijs++4hMYWu/F08z3qZdEGlKhLDgqiyjYvVe1xAEuGPYH/JV1NaDUjNypWPZOKA/M0clfRWvcdedahow1AhBTFnzDnwRmTgQTnqtJWkVGmq8RQFKZID7IOxzzCJpcaeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPZoVqsE; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPZoVqsE"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64175f78a6fso11432a12.0
        for <linux-modules@vger.kernel.org>; Thu, 11 Dec 2025 09:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765472619; cv=none;
        d=google.com; s=arc-20240605;
        b=GWgDtkzIVOSh22LEpBeCsUTOC80caqKD6rWKDWGXvbG9kN88fQ/P4FanNqcx+seWYp
         InO9zA5xBz4uI4Fod4Lke6CSOipr6w+SIf1DamWRJD+2Sta7DddLoi2eayT3sJtr5/tb
         QkVmuiAScMTYLaMrBzfxQ8ZhCGLqKexoL4xZX8Of+m4mcEVONKnDSD6cKOEde3VkBWEY
         NAVPiM88JJjDeyTSBHJaS8IxIY+2ryXogB/3bMwHNivQ9I7L4JhBX9zvkjDuXL9/mnQg
         9PNk6jFhQGLjkBGots63r/cR6xiqSwgRimJ5vH6xVm6e5V3k0/2dQQivhlnxQ3Jdvjne
         63Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PVdcC9AVWtN6X0R2G6LEfvI3W7plOZrvAmF1E2ynVb4=;
        fh=z9wk8ojUlYtUAirP1kDnpIG4lPnrNyNAnxDiIPqMbPo=;
        b=bJ4il8tfWieG1JItaBzP24RacQAp/mUeIAWOXSyir1J+KrMlVH4E8zZYnk9fVi4iMy
         tz7ZqSER5bwRVJbkVNYal7SVeRAWQxxfsS5HKMUJge9uBPYU5GTr7HaBitoFFfmcWBz/
         CFt9R2b1hhMhGeD0jolBKLhZRPeftMKHitdj8AboaoOs9nTFuF9U+Qb2MOGab5B3tk30
         bMAjiqkGZaZ2VQ8WN0Nc95SIt2M4i6b30744hvPpMkW1xMg6MMZH6rqekcSj3RL65UjV
         6QMxRkmaaoQeq8myUblgZEDAtTLJ9/75Jh5ZYVgfGqrm3IM1t8UJZCNDi3BbxcJ2I+aU
         hgkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765472619; x=1766077419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVdcC9AVWtN6X0R2G6LEfvI3W7plOZrvAmF1E2ynVb4=;
        b=PPZoVqsEZhurkULXCRc7AZUKzcXInkbTplhWtlxNZQ1WXEXlWBz8AVOTi4zSNj/rtb
         +AGcVOuDKhLCmcbrN/NOWYaypGHfvuI42h8qoGlk2BD4buODzmRBsdckMLATAqNJzIDI
         V/MksXyDFHSGT6ulp/LmXtj5AuDm9ZZHap6IeCz0E37BBkxXC9SRekqbDTzroKAhIuSo
         bsqK9YIRqfqrOtWB7wdNxeGZbOBoB04g+1xBzaN/bP16JET6+/7kW1jKCjLP/ix3Pmkj
         OqOsLvgizq1cpQZtWLU8hbA9q0qAgTULxKb9Am/XHb1LhFMVxK896fzzWS5s55FhXkXk
         3MOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765472619; x=1766077419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PVdcC9AVWtN6X0R2G6LEfvI3W7plOZrvAmF1E2ynVb4=;
        b=M0xxSVjeZQcyTXlWtLDlKWpfB2JAbQgvex76+WN37eikv8H6aqqmbVcuFD1Gb8nAsR
         pyabdFCrTmmsOcnp+yEuJvNZ+fjBvwy229xQsIMPRqHEmGuTr2WO6AXYWe+vzYfMFMFy
         4S6v5kXOCzHlXzd0LyTXAbJ3/MPF6+vxWGh/5XehAiclsTKZC9R8baRQtRJBMnVoZ7xD
         f9AoPRpl0JNHlP/xTYSPGoRVpydcbrm6UzVOb9Lvm9K8vzuKfED+Xy1t8Fiw5J88L0sO
         0hFN+oeRDm1a2usH/z8fl94LrNvpf16oE9OpNoajopAvzc862zg1sS88sPR3y5wG1Gu7
         8RaA==
X-Forwarded-Encrypted: i=1; AJvYcCWjrCOgbc0Ymysmcezh8WUGNGhrIrFXERnSgcoSzhDsIrZ9rhzXsUhcNYMXKDZgfG9cgtNUn2pBBlnelwjD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8aB3tUxVsDlPzH9HuZ0pa3OjwR7snMDxLyAZH/TTZK3kA28ds
	8/o39R2LvanWlSO4hOcd6lS60Acx5uSm8+eq73/M6oOueukEweDqvRMhfZOFRmYtJ0fmJTBYOhE
	5Ldq7Nx+sQXF7pD9lBNxxqBsL7QxqrC/RT8TIQmew
X-Gm-Gg: AY/fxX6NCRElKopeg3bP8S4mrK9RRu5EBbM4gqymR/Veilyz7vVR9YZATFKhVCKMhEk
	OW0i9DNPi38u+pR6CmIkvBIhUP4eg9zeznCgiosCsxZXXlvGFiFfr7SaEco/af/sfXa8JjzrwGW
	He2p5OpZH/VQGYG9sDneyZrYPae8xCj9OJPhPHfmvD3FdVeylPFb4+fO5JqkD4V1jQhKu5FgwfZ
	+Yior0swLBZeQD5sRAaxk1Nrt7nyf31oURZV8RshAwZ73lln9VhTyiDTUq50ZLDLsGuTwVBqk1q
	rqs=
X-Google-Smtp-Source: AGHT+IE1/twXkBw6T9ZDd804UY8hfxB7e6+cB8iDcmq/fCjHoXaBhqis+kpZHtSWJX+Enpr6HBPUEcW+9sWfx502HIc=
X-Received: by 2002:aa7:cb82:0:b0:645:21c1:28f9 with SMTP id
 4fb4d7f45d1cf-6498600598amr51468a12.17.1765472618955; Thu, 11 Dec 2025
 09:03:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008033844.work.801-kees@kernel.org> <20251008035938.838263-3-kees@kernel.org>
 <aTc9s210am0YqMV4@agluck-desk3> <20251209001139.GA7982@quark>
 <d3dd8fc8-ab46-4cf1-87a9-0324685ba2e0@kernel.org> <SJ1PR11MB6083C6D97484ED4E4710268EFCA3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <aThSGiKwJRYOB6kx@agluck-desk3> <aThqcq0iGge1pQCr@agluck-desk3>
 <20251210010020.GA2522829@google.com> <aTn0WdVv-S_EpQmS@agluck-desk3> <aTqAxfiVCR2ch4I5@stanley.mountain>
In-Reply-To: <aTqAxfiVCR2ch4I5@stanley.mountain>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 11 Dec 2025 09:03:02 -0800
X-Gm-Features: AQt7F2oUBa6EQ75AaBiCKmXyExf-Brdy_futQsfDUwAYhQV22rWe0uokYAyYkCc
Message-ID: <CABCJKufWw4VQA_k6Deuf5Bn6401cbYv_St8VV_0-LAau6F0nTw@mail.gmail.com>
Subject: Re: [PATCH 3/3] module: Add compile-time check for embedded NUL characters
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, Chris Li <sparse@chrisli.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
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

On Thu, Dec 11, 2025 at 12:28=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Wed, Dec 10, 2025 at 02:29:45PM -0800, Luck, Tony wrote:
> > > diff --git a/expand.c b/expand.c
> > > index f14e7181..71221d35 100644
> > > --- a/expand.c
> > > +++ b/expand.c
> > > @@ -535,6 +535,8 @@ static int expand_compare(struct expression *expr=
)
> > >                     expr->taint =3D 0;
> > >                     return 0;
> > >             }
> > > +           if (left->flags & CEF_ICE && right->flags & CEF_ICE)
> > > +                   expr->flags |=3D CEF_SET_ICE;
> > >             if (simplify_cmp_binop(expr, left->ctype))
> > >                     return 0;
> > >             if (simplify_float_cmp(expr, left->ctype))
>
> I'm not an expert in the C standard, but this feels correct to me.

It only fixes comparisons though, the problem still exists for other
expressions. For example, while `_Static_assert(__builtin_strlen("")
=3D=3D 0);` works with this change,
`_Static_assert(!__builtin_strlen(""));` still fails. Perhaps there's
a better way to fix this than changing each expression expansion
function to handle this flag?

Sami
