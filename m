Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7C328DEF3
	for <linux-modules@vger.kernel.org>; Wed,  7 May 2025 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746658749; cv=none; b=IBqk++DVQc8HNpbjE+d4pR6VEIRPcZX/0S6bQCrRDC2NavzlomZME5+QJs6B5Aac+NT0zNJJd4hn8BOmL3eLKjFLYtlDo2ekLN3bF5hq/DWl79resFdHLf5gb+BZQDEDLhjTnUnO1pTF6cYESad2Rw+aEA0fyEef3/6QcymWTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746658749; c=relaxed/simple;
	bh=4qznrIQd9heCD85pUFAjDNFme4Ro9HM6p9y3geLJfT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEQzPRqtThfLMZGD3mPmD1KSw+p1ravywgbGpvfHaViG3IX0AblY5Cl7vnNuR8UdWpIVKHmas6Ktttl2JKFzyGfrhznMrd64zbgi2QGisXFOrP6v/nLEG4sLul15XSPGw/p1qLMwb4OBH0NQPOs2SOJM+vO4WDllVVbfVURH1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sugdTwtC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sugdTwtC"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso2221a12.1
        for <linux-modules@vger.kernel.org>; Wed, 07 May 2025 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746658746; x=1747263546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qznrIQd9heCD85pUFAjDNFme4Ro9HM6p9y3geLJfT8=;
        b=sugdTwtCFYvGjVFdweSDSrE0kpQ09IL+Jip36nQTXjB0TdLKr/tZJIlN7jt8ukf2DY
         w5SO2yNGzy7Q4cVWIoqnlLt/nAwaSgVFsKijS2XZ8MFyTKTZvkSX5hm9qVvpmzJ6l38q
         tVrBuI13GAl/r2paHdv1EaskwPtkqV5GUMdcoitnQ7YNAH0+V/u9R7akJQwpV+dRHlwE
         qpeStstt3hwxwfGfcjBu+yAEOlRFfmAUcKDLNJzA06JHw7OGCF6GQM4Eyn+9huMvoL7d
         Ff1Va48luWQMwjfeOJJfDP3eCLkFedKXU72xcNr4DvlzCKuPO5PFfbcgbzl0gvlLFEWT
         aQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746658746; x=1747263546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qznrIQd9heCD85pUFAjDNFme4Ro9HM6p9y3geLJfT8=;
        b=wMiUjzZiFswZ1TsARiK2vUxK4Qjik+cVKGkpopPOvOOxvonWWbGAD0kWXVZ9wOAsHu
         OliCW3A656N8SrZi+LoOKEh8b6HHm2t0ilWch58E2THLR7CVyZzasg/mWxy6yNopAlyy
         boza9s/ZeABA/EFM0tiCjmgDPYreKv8m40gBSsOBjMkn47FVD+Glzrbti+Ij9LwrkWSF
         BdODCEdvpVgRKMXRrB+SgIJDb1TjXdJC/PIAUdHDq9Adu/D+3f2NyonzvZIa6V7VKghM
         dL2ElppBcbr1S3Jyi136Gx3f18QyQq5YGf2qpLDYtzW0HmvD0hxA0r3ZUXjiCO/HShN/
         xYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAp+9ru20Koga0i4uXoh6uJAEmGYRIx3Xr43bDnHSPzM3DVJ+fiGRjD1bj5ywnzJKYilVZ/ge9vLOy0vrt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7uv6xuKQRHHqclPgHoTbGzlxTG0gdvksuYyb01GgXa3o+OCjM
	BKii616RaOlQkypvi5vAste0vxCgnwD9cEZ1t7dvX8aAxyYlDtLTerJv4w74w4muw43cVzQMLsM
	axGgPQvelcCBb17Se2kiLjx6aB/A+/KxQAocK
X-Gm-Gg: ASbGncuXhA3sI+If0INWNTblQ8IfMGpOV/GZRbIW3hA+tRZGrq87UxJM6PIgMquqNRC
	gAQKMziPjH5/bVjDYF73cTeCvejgfN67+uDCwqHtChEms/EffKqUU3y2lxU5s0PzeNngLHHxQ/4
	PDBhiMNvNj+An/UbNEoqVv35BfHW2Bvde2/+fHfARBdj5wfHSv9Q==
X-Google-Smtp-Source: AGHT+IG5UM76A79+IbRtPyKJbFmyzXpMUKCWJ9hqDVsiMGpyhjFhDGSChhn6i9wySXk6B9CqU0BGHm8UgBUgVRm87Zg=
X-Received: by 2002:a05:6402:1a27:b0:5fb:ee5d:b5a2 with SMTP id
 4fb4d7f45d1cf-5fc6d4d522dmr15802a12.3.1746658746142; Wed, 07 May 2025
 15:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505212401.3379699-6-samitolvanen@google.com>
 <20250505212401.3379699-10-samitolvanen@google.com> <CAK7LNAS0Obe-ye1ba06EfZ+mgmc6ter+xMa+mKCw6aRM14L35Q@mail.gmail.com>
In-Reply-To: <CAK7LNAS0Obe-ye1ba06EfZ+mgmc6ter+xMa+mKCw6aRM14L35Q@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 7 May 2025 22:58:28 +0000
X-Gm-Features: ATxdqUH75sjGKquTsxZiAfvNfjaDztMLHXgmmKdCV2-0xtfGeIwBKHIdY6DuK4s
Message-ID: <CABCJKueJ2+TpUyJsLOuy3_Q324iOhmKm50vf4UvRot51Hbi87A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Documentation/kbuild: Add new gendwarfksyms kABI rules
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Wed, May 7, 2025 at 12:28=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Hmm, renumbering is annoying.
>
> Maybe, better to stop managing section numbers?
>
> For example, see this commit
> 1a4c1c9df72ec266f94631edc59f9f2a9dc5aa8c

Agreed, that looks much better. I'll send v3 that drops the section numbers=
.

Sami
