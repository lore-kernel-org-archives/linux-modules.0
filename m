Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB7938381
	for <linux-modules@vger.kernel.org>; Sun, 21 Jan 2024 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705866905; cv=none; b=SHPAuLaS/ucT5i9dg5Lxtw7OhWCgpEQedtLIp42jMQ8p1vDT3W3hSXRp3Dp4m/c35Daqh8c9d66kd10LwntYLvA37/qc6dVrsIGN2zfLJEFjmHCtX3D5D6Gt59qUaLmJ0nZtMlULrvn1LGUVSILK5fRp3h2Ete/WLYZe+wklJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705866905; c=relaxed/simple;
	bh=GQoIOMmGlZGhERzqT+E6aQH5Sj5SbWki1fytWD9sPGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVUYWi07TZ3L55NwVVzia8CBNO1u3oZsxS4qd6BhkRCpP7aRT8r7k248zC3/eQWQ3mPCIHSm31ZKZDhsEvvUYBz2bH2+rCPabe0d3FbdGAOjZVNa4kt8H+BOwPibV2lsENYqDWWGe7MAQYA1YnbYMBWcTj40iEfdkIC4Wi4ywiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NLCl1p14; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NLCl1p14"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd46e7ae8fso26547631fa.1
        for <linux-modules@vger.kernel.org>; Sun, 21 Jan 2024 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705866902; x=1706471702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PhjJVX3QcOh8OZyy81TIER7JHK4cm7N4BYEGM0PaABA=;
        b=NLCl1p14Y4P3Lb7FdRy7fHEB/SgXPXxftFv1J90itxs0TRmi9fyxGOaC3/2fCc3Hzr
         YbuO62gEsI/8f6/PtZ8xpvZy7PD8coqcykc/qJJwqv0VDIk6McKuaySI2CnR3mkSfVd7
         ozaGSogZGn43MMaAqIgD22WCqSqbGXCFpHN/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705866902; x=1706471702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PhjJVX3QcOh8OZyy81TIER7JHK4cm7N4BYEGM0PaABA=;
        b=TJY9fcoemn4Nml8JegtFEMWVtZHIQ0h7h8wJtRkd60Q2NjyzUsBzexVIGYB1zOvUS3
         FfOLUVh8UqNlDgQdwIzVQGTf9NR31Txx9e6+z2Vuqpwklqq1t5hIwVdkvIc5eF+iQRbe
         aBSyR6KkA55wZWzSiGU+wdtqp3pGSl2eNuJbDqTHmrhMp9KZbbvByWa2o+pG/o3E9BDr
         msxAafOzD2wg2M962PXL9l6dYScuG1Wv4VK3GHgoKsP8EnGRTUMZ4TvTYaFSo2L6eAnW
         03KpqGasJdgl3NJYch+q9ghSG3qTqiThGUQLEVLM0lK/FvMptk6xh4kRIzsyTatMjAUx
         dxoA==
X-Gm-Message-State: AOJu0YxxPvE2N+SpmRQ7loDYxW4LaHlxIfgvR5S5vAaYnbssP3iBAy5R
	ksLmqZXzvnZ5fnHVceuu4CWSWOWG1QKSoqXLaZFcoXpP8w24+s00rrDhiwWJko4R1rFp1ITVLsM
	yKHCI3Q==
X-Google-Smtp-Source: AGHT+IHsho4c1FzA+4Dv0TMYto3NWfjYZZCKYgyu+2p+o/nIjPaRyZL4eLeWdXxPalNd2E8DP0Ej5Q==
X-Received: by 2002:a05:651c:c95:b0:2ce:dfc:db74 with SMTP id bz21-20020a05651c0c9500b002ce0dfcdb74mr354340ljb.135.1705866901951;
        Sun, 21 Jan 2024 11:55:01 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id b10-20020a2e848a000000b002cdc1beb671sm2246280ljh.12.2024.01.21.11.55.01
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 11:55:01 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cdf69bb732so24511491fa.3
        for <linux-modules@vger.kernel.org>; Sun, 21 Jan 2024 11:55:01 -0800 (PST)
X-Received: by 2002:a2e:bc09:0:b0:2cd:a774:2714 with SMTP id
 b9-20020a2ebc09000000b002cda7742714mr655928ljf.152.1705866900796; Sun, 21 Jan
 2024 11:55:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1rNVlL-000qDm-Pg@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rNVlL-000qDm-Pg@rmk-PC.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 11:54:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgUmXuxtbThqBNREhihRJxrDjuOZRUe8DiwJgPOc7d4zw@mail.gmail.com>
Message-ID: <CAHk-=wgUmXuxtbThqBNREhihRJxrDjuOZRUe8DiwJgPOc7d4zw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: detect depmod version to exclude new SHA3 module
 signing options
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Dimitri John Ledkov <dimitri.ledkov@canonical.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[ Going through my "this is still pending" list ]

On Wed, 10 Jan 2024 at 02:24, Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> I don't know what the minimum requirement is for SHA3 to work, so I have
> chosen a minimum of version 29 for the purposes of this patch.

I see that there is some noise about hopefully just getting depmod fixed.

But if we take this approach and just say "don't allow SHA3 signing
with a broken depmod", I'd personally be happier with something that
isn't version-dependent, but is bug-dependent.

IOW, instead of doing "depmod --version" and parsing that,
particularly since apparently the exact version isn't clear, would it
be possible to just actually test for the bug itself?

Or, honestly, maybe just extend the depmod wrapper script to write our
a more descriptive error report. We already have that whole

        echo "Warning: 'make modules_install' requires $DEPMOD. Please
install it." >&2

thing, so we already have run-time error handling (although I note
that it does "exit 0" instead of something saner) rather than some
Kconfig-time case.

                Linus
