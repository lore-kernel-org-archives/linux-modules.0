Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7234D382
	for <linux-modules@vger.kernel.org>; Thu, 26 Mar 2026 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774560721; cv=pass; b=QUOPEdHRgm/W2Z9IB64vUFmwaLJJqIwEYi6xBvZbKPLNvw6ETWTr/JQ34tsVrZQJWkwyUyR4zS/ZXLo9mAyelLV4OfSSJOw90xVRa+jQLt7cARbbbNbqL36IJ6BmkWNGbvBtwhseceGWCEhKk/VFTVh39XNFXmU7Isi5p7LxCj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774560721; c=relaxed/simple;
	bh=TZyAuJdbm5lNyLHWtj8JZifMocqSIEE/M15yyD9cWUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i+AuFGPjPglPUZ44Y71365haJQAFSFs7iFkc9gpsMFB7JoLr9Hee8HpRIKOwyOuJGxYEBvwc2bCUioVGDION9jcNCE3oSgLWqVaqDaNhBY4BKbmT2hfag5Vdh7Jx7JEz+E+s4wuZ85Yms8xmaeEYv1O64+/u/s8+tihlNeNNNTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kho7DaWs; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kho7DaWs"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a2ee65171so15379437b3.2
        for <linux-modules@vger.kernel.org>; Thu, 26 Mar 2026 14:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774560720; cv=none;
        d=google.com; s=arc-20240605;
        b=a5L9ry0TjUKXTp216/OHGBdatQf4lcA1sagBUQ0aqL7USeKzho8djDIVlxLSL7zXl8
         z0+jcEXsXJH7MBtmZzq0tRfSbwbk33BsI6nGbhAuhkpGWJVaQRt/QcfQVxJSM2mO1hHJ
         4eVtBgIu3RzmOnrXZldwUkhiPvwgZW3FdW2W5zMDNV0b+G/9v6uy+3sR3QYbfSEm/1p8
         gWzG+NX6OIVl+toKER9x9VcTpbq0dNL/9DaJaYf8rMpWI/UtHEaAPVwXelwgtN71Qecg
         z1A1Eu7UzjGQfpRx0y7a2Hqd9vC/iYxWaFvf95CqHp/0Bb9q3iu1SRzWhcEAdSSUNeQD
         476w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TZyAuJdbm5lNyLHWtj8JZifMocqSIEE/M15yyD9cWUw=;
        fh=DEYHiqj5eaI77JogLWkIH1jKQr21yT0oIqNQF54tfKU=;
        b=LV6FypJC8moPGHh9zgG2WI0S8yK9d6wPsUfVYHrvH3Lfm5G2un6oBKOEawHF+9FK9/
         tkxs9QqiZjB6bQGCFlK2r5feFhajOyeK6loOPgI5D4sQPoXrDbEWlNKl1Rhj8exhmA0R
         3xb7lhorV1n1fiHyfWf3j73m7lyH7TUOZ+tvCMWEYENX6wVDjP6p0xc+4Mi/jOz6Pe8v
         X7WPLZh+pFLjbxLFfsf2pak9nD90No8VXdhLovn12Q4d9H1jHZ9GyFDwP1qMaC/hmK/v
         tHC7BWKUrqjfzUMZS2dKxJwMKYy7v33XJCzxDa6hx+508XCDIVDZl+rnMnzSu+meCvc3
         A/jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774560720; x=1775165520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZyAuJdbm5lNyLHWtj8JZifMocqSIEE/M15yyD9cWUw=;
        b=Kho7DaWsIEK9g/9BJfiXPxDaRWvRSlr9ewjSWhZ3/2jVk7CTpXsD+LMoESL1iui1KP
         AizCuJYgmL+z5WuW900A2ZDSNB24rn3OMknbhvTvkaeEnfpew564K9JouS/ubzDclFcb
         u4h9L3i56FhJQIdnr7oX9QRGOjCj6pINHt9s4Ll4B7MQLLbD6vT1iSz2ui0En3rmrSNV
         xM6JSKvn07/GFG0caP4tW+mUgCMgeCRPWkYnxIsWIA7Q3a+DsGLoeE2e2nA0nOUIVh4T
         wk7nU+5HATu2tS1HYl9MtrIoSioadmZB30NV9ZfZDB7hjer2F2X99FQrTVBasg7zfz5K
         8SKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774560720; x=1775165520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZyAuJdbm5lNyLHWtj8JZifMocqSIEE/M15yyD9cWUw=;
        b=K8aTWvkT5SrRvg9nXtRQqX7O1AkisRnktiWf/mNHfJUeNxicrRR6k1B1XS0NpoZmGp
         38EPdgInyc5/PuuI07H16OmIZhGrmpHNt2U+DX9vypS2dT9MLp57BSigHkuRiSGdNe+1
         AL3rnR/FCyOvbWvA1a/oWubhz5G/U4tOiJRAmdITdPQxwun2CjIvbyx/FOYfr8ry8kV+
         Z3iNIuipegxQJldYnc6BbWBzgygigFX5noY205YKQT5NEAdhN/ffCIaoZf7tcqrDpa/Q
         luPjlKo9dMUPf7Xr/tZcL2Vdr9DGgl82RiDTxu7WupodOJcNWzRExYQkUG/OOps+njDM
         dbCw==
X-Forwarded-Encrypted: i=1; AJvYcCX5RhbKOG/mJ1D6TDxF8CweGTQYxG6Vj7nefWKtzD5F19deM6tOBaPIhxX+pZrpA0V2rbgC/VVAHAVqPbhE@vger.kernel.org
X-Gm-Message-State: AOJu0YzgC3LLtTHYleM3CR1WfqRAqAkIdwEHR8YzLtcGgUM/fjJE5iVg
	2Ldf4vwh132VBBNcI2LEmO6rIsphwBzDi38uiHL0a9Dnh7e0HX5M+7caE6O+OXKof9c8wk5SuVm
	J1aXzGv9DCuKbAU+Lc4laQLIk/l2r4c/u+8XCHSmt
X-Gm-Gg: ATEYQzzkrdep99p2A78doLUWmP3SlLFHBwuNzngWWh2mTaHpGu3ZUCDFbayhZ69kECE
	BbzlrVJdUUTIjT0pCqULXXvZdVg7WVmCHVKvV9AYGZj/a2M+a0Wo9/c6nQn9px5GkVK3xktonja
	+FZJURwjo5JaiiSp6yo+XriaI7+sii13q708yQ2KOxnXvtqCAPE1GKRtYNGMqvmYpqJUKpdoZOI
	Bfs7yHklPp/OtU/suC4X7MCezRxoYSwr/GHw1UGIYrNc8uKaSAwhdjmbE0HkbfevFbNjXZ/IK81
	OxQ1XGre
X-Received: by 2002:a05:690c:368f:b0:79a:b409:b62c with SMTP id
 00721157ae682-79acf39ca9fmr101703267b3.22.1774560719217; Thu, 26 Mar 2026
 14:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-kflagstab-v4-0-6a76bf8b83c7@google.com> <b83c9524-13df-47dd-a597-bebab93288d8@suse.com>
In-Reply-To: <b83c9524-13df-47dd-a597-bebab93288d8@suse.com>
From: Sid Nayyar <sidnayyar@google.com>
Date: Thu, 26 Mar 2026 21:31:45 +0000
X-Gm-Features: AQROBzDfMgZ3xEPPX-07HtZ6qMri8pHd4_VLlgIvmfka8IMZId9kQN4ffSRsYhc
Message-ID: <CA+OvW8butx7OD5ArjWXm7osCf4tV2O-suNHcHj4gFaQfMMPjwQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] scalable symbol flags with __kflagstab
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, maennich@google.com, gprocida@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 12:49=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> w=
rote:
>
> On 3/5/26 5:55 PM, Siddharth Nayyar wrote:
> > This patch series implements a mechanism for scalable exported symbol
> > flags using a separate section called __kflagstab. The series introduce=
s
> > __kflagstab support, removes *_gpl sections in favor of a GPL flag,
> > simplifies symbol resolution during module loading.
>
> I noticed that the series has a bisecting issue. The module loader
> doesn't see any GPL-only exports after patch #4. I think you'll need to
> squash patches #4 and #5 to fix this. Alternatively, the patches could
> be swapped, with the caveat that GPL-only symbols would lose their GPL
> property for one commit.
>
> Nit: Please use simply the "module" prefix in commit subjects:
>
> #1: module: define ksym_flags enumeration to represent kernel symbol flag=
s
> #2: module: add kflagstab section to vmlinux and modules
> #4: module: use kflagstab instead of *_gpl sections
> #6: module: deprecate usage of *_gpl sections
> #7: module: remove *_gpl sections from vmlinux and modules
>
> The changes look otherwise ok to me. With the above fixed, feel free to
> add:
>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

Thanks a lot for the review. I incorporated the suggested changes and
sent the revised patch series for review.

Regards,
Siddharth Nayyar
