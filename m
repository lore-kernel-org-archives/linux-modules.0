Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D403361DB1
	for <linux-modules@vger.kernel.org>; Fri,  3 Apr 2026 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775251451; cv=pass; b=E5F0j9ZiJmnjyPi+fXMb/1R873/XWCjZErwALnzsxbA/pCYEB/ZcyzQLehNeo6oLYrtaMniDZCP2E+PIS679iAWlrWu2xBHQ/hZpg/ES3emZxz8sBC9i653GfvycN06r4HETuTVOcZLHgs7lftRZgdLGD5iVaCXvLTqSVq9ojmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775251451; c=relaxed/simple;
	bh=Cs3nAqRjHjioxjYHhaJzVFtzKHaPCe2OYhO+RwJxfGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZveSPy1O1vXYistUjY8wkIkgwqdh8jufYBOduJw/FuIQ1Git5KCzpgDFnLx+6DTJ6EroMunDTxQdFLC+n4iNY2jsWZA8ZcdcE41sCBZByn9LTe1gDpTt/85TtDsTm7tJKX/m/JHGVf5NVmFmLvj8zHu+MjxvZG7r5gQ3VDe4brU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRoXO55O; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRoXO55O"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b8095668ebso162069eec.2
        for <linux-modules@vger.kernel.org>; Fri, 03 Apr 2026 14:24:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775251449; cv=none;
        d=google.com; s=arc-20240605;
        b=jfDpOceXidRObfKUAoLUogX7w2V0mLioaFwv3RzKvJfBcTvpAddu0dZHWP0cTClMFK
         5grM+QwXCBj+iNAjXujb/kQnoT1aoE4LRBe/oCVCKV5kbH7fgB8vU5KeYxj+4RPvW8Mt
         inrOOXhfQMKD0XXfi3YW9R4Rikok0YLqdWuEVIEO14CA/7b9LOodnVg4e8L9Jm2N1gHE
         DLHTB863cLPiFfVq+lSZEMyR9smxMnWeyhK1wdSTI4J5EY8+uNgIZWQONR7+Z9P5Eucf
         DEQImLWkrn3u/OQIlYFqZAPRE6D3QkgkyCyyrBF7SYxoCSr5tFss08Hm7Sa4ypVrPFjA
         PbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cs3nAqRjHjioxjYHhaJzVFtzKHaPCe2OYhO+RwJxfGQ=;
        fh=kRcV+3B3vR6LGJlKrxDfPai1g1pdfwdDeOTz5RGJYnA=;
        b=XfyncVeSyQ4jQP5rzOIDMiHbG4Ka4OVpn9VCsUkYRsNWcFjdsCAUxPaJgwpjyHhRCt
         XnTLoX4V+uSbitUg4L2UXc7S5JHcwcIAssXGuELs+ksOCd2MlyPCynwtPiBmJS7f8/WK
         orkOTI8NyI4GTsDqaojPnyvewALzPM1QEj2H6XsXar6tOfDYTEAajlzw4glPpHNcx5aN
         YCJYDYoGEQ97o1X5OAa0acory9ei7k/1ZH6u/MLyJZH3AvJZ1GEj1e2WVd1bwSLvhVgI
         H78c3otj7/ij6D8uXZ+ek3j9vAtfqQAPlOH4+j5uM56syom5M/C2rWxyE0imF+6IxtPC
         f2cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775251449; x=1775856249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs3nAqRjHjioxjYHhaJzVFtzKHaPCe2OYhO+RwJxfGQ=;
        b=MRoXO55O/3wKUufhV3SSQkDEWLLF7sw+4UaSow6fSGuPaqpTLL3joUlLfqAIefncsx
         hmOOuDT4NsMh6dbicranaiy/KMHKd44INZdXmVsvQHuWkn8F+q/6PSTEtHh3++cj1zEz
         ixtkye5Hb5iHk6KcFg2z//zaU2mbBWJAVLQCwPEgLi3bGjU3P5aMJdbIfgQxXNY+9tQ9
         WqUHSj3kWddcy4W/sHeiIeiElH7guUfjdPJa52bD0j9qx0DcytjHoaOFFCcHIi6GoBc5
         0VzPPCPs5daxSp4VG2OJWfXIkOmRiKr3k1PE0m6AQTIdKb6WKdMxBPlDS5SU6ykcKSvF
         QRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775251449; x=1775856249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cs3nAqRjHjioxjYHhaJzVFtzKHaPCe2OYhO+RwJxfGQ=;
        b=JsSBvIHZfzvRdaunHwlpdaCFsyUFnDkYwkUdGHXdT+dinGPIFWEPjvUpewYiDGqJGC
         TUjyI6ufIUp74FaP4npgGauGPGXF/Fp56PDkWqKiIu+lpCTjp/8a3XxLOFb1HIsI0Whi
         CL75Mm4Yed4s+2zNyXddoeJRTsHGjTmJgLTmytlyClMVaNzSSPWyJ1VTZy+HVliFLuJI
         e6uEJ8WkM8frhNENuGWtZ+bi29pdVsNFGTKCt8TvbI1wpbTBdefX1aQF1HvaO4WCUoYQ
         KEyhtg7XbYNKIpco0Blnuf9kRdyOqMJfXWqDS5Uko7ui0oNoDthvdfVYtWtplkUppg7I
         91hg==
X-Forwarded-Encrypted: i=1; AJvYcCWp4e2dR1Cf6RvOOQl/zIMogh+kkqdUo2QrgvO/h3ewvY4qjRar0yt53B1AcrOtRDaznBkULx4JhedWeGuJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwK60OuzT33xMcnPPw815jE85IbyArRKsU8Rq5x04cV9Ly8qpvE
	SwWd9NJwpdjj8z8uCWRxl5IO9bJa60vBr5xSplWsYD1Y5OrsWgb+UlPvE75XxqIe7mYtciCKhw5
	1RfGmPf4vMSGXjF25uXIf5/zXZFOuYJM=
X-Gm-Gg: AeBDieuDwmOtFpTdT1JxKZCUjYslEFBaGB/FnARKYcJtLWf9lohAUH82zRY3BYjh1m8
	057uLmqMfgeViDTsXSSWdlIailPFFsOgsvvSfGWaWHE5b6ycKxhZClVNCaaFujsZHuKAtoImybl
	MeXfKcewUssmx8dTt7y2JGujIe/ySe5vT913VV18nHtU4/D56vgSXDNHiWgnYUf/oMLqEY+GStq
	Y/2+iFCQT+34HxuwN6Ay+Yhgzo0T1ab0t68mL0CNiFy8TOdasA8Qrxb6yhl4fHzR2prxquVilko
	cGDiV2ZRW/0yH6e49MtfmpUBo94zu4GRw/5YZz/L3NIjaCCmX8QwI2pBl+Ylyw3zWXEjwLl2S9G
	IpJlJvQpE/wn1klGxlq9GD58=
X-Received: by 2002:a05:7301:d1b:b0:2bd:db75:c28b with SMTP id
 5a478bee46e88-2cbfcd54f9bmr1105240eec.7.1775251448669; Fri, 03 Apr 2026
 14:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331205849.498295-1-ojeda@kernel.org> <20260331205849.498295-2-ojeda@kernel.org>
 <CANiq72kNqmGpFurRy2X+a=9fHV_hxpfWBJ-+dEL_qj2daLM8ww@mail.gmail.com> <CABCJKucPKB-ntYi=EzPqyypy0kEHwnZvEvCEyjdQUWqfeAnGig@mail.gmail.com>
In-Reply-To: <CABCJKucPKB-ntYi=EzPqyypy0kEHwnZvEvCEyjdQUWqfeAnGig@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Apr 2026 23:23:55 +0200
X-Gm-Features: AQROBzB3MUuJJ3FThSbyL0_qVKcvYvwi_z1x37J_iBtfZ4z7dOAlfjoh1a-7qKA
Message-ID: <CANiq72==CZDMbjq0VE1e0ov7uLoSDBs_g3TR8S=EfsyC-m0mUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: macros: simplify `format!` arguments
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 5:53=E2=80=AFPM Sami Tolvanen <samitolvanen@google.c=
om> wrote:
>
> Sounds good to me, thanks.
>
> Acked-by: Sami Tolvanen <samitolvanen@google.com>

Great, I have added the tag now -- thanks!

Cheers,
Miguel
