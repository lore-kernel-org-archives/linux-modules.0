Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE232142B
	for <linux-modules@vger.kernel.org>; Wed, 11 Mar 2026 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235397; cv=none; b=Y1r7GEcI+aM2p96wywO23Eg/YyvYtmkoJYH7nXwNgc+WQ23qFTlqtsWQb/8B/6angyi6xgvH/kvX+vYH8Ogb4A6vM9h+AHdkozz+y+blqytFo1pZh3spqFSDFYHooCmhMVkzRas38hRJx+sHekV1L3ldbcJUaO2TpMJhn40rEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235397; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBvpkpL+8GbuZ/0vRLPvujRAjHp+jkAQFDo8tantaMD8ftvD3ZbXDV6RoxFwWYtzJVIGs83Bvle0M5i3IcQQcDsnfo9qZLbwN9lOWyNyzdygQNhmT4lXkJY+kDpTy3UL0qST/YZKNp8DaXEwLaLhtjnY1Yr55w8BSNMU1EjAO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2423889e0c.1
        for <linux-modules@vger.kernel.org>; Wed, 11 Mar 2026 06:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235395; x=1773840195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=tjszCG6ml4ZPLcYzQMbMqHLwI7OqoWuFSkl0ei5648VDdPYb8LZ1mIYjSeLapEu4dA
         j5VMUlLUhihl0glAGU8KWT0JqmWWK5ONRSwiR+xzvPwgRQJTjX/2dGwKqe+uwfKghp1r
         8iOvwXRSVMB8wV91ym78+FjBXwflhhSTBgvXdzH/Gf2vuKDlEiKmVVfR07endjzS6uCQ
         QnBiygEJp4kBCXLyCzIzq4mf1rBxLbWXka1lxsFIyRe/FLq7jl6GtH6GLpQI/Qk7ucsf
         7+ohZVWPMVhTtQWUuvuVSzP/0Al6ZV9HNUx6QPK3mESeYs3AgNHNP+4x+H7FG2//zxkG
         b+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCU6bX3F3z7UjkzxSA9oBuv2cFJuqMJXCr1uVCZrLDvzXSVM5MSr2xLSGlUTrKZbOJY/6dFrPBU/rxBPr1dg@vger.kernel.org
X-Gm-Message-State: AOJu0YyvrRBvxfBoYeUyaTl29jaMUmvB3MBqbWxhSw79kMaKx/9wx01v
	o+H1SkGrCupiqmz9oq8w5fIMTxb6ghXb6jZhlC6/uTwJmUOmzz9JTzYyIiMEEkgqIuQ=
X-Gm-Gg: ATEYQzzgUVBuD10xN2EZTEYP6B8z7iV9G/heRIYEw95M7tKILUxq1Ah/8lMRXFV+MK1
	Yf1K8uFCTP4fvRKqJTFhjNY3TW2NcnjX6Nn/YgkSLM9+mX/9MPyor0DC7/iv/t3Xa5f4VajqYi1
	9RjcMMOXXCLkb8w3XyrdjeB6TZz4inSwTP3ZtXC9IjwpaQTHDNt1QfhRQbPBQw85FsnzzQmEKur
	l+n8erMyIhkCpl9sudZf1XJmIhpqK7mwrmiBtay/Asus4j1ma6Nx44zZi/ozLFt3d4Kmaz2Ipl+
	KpjPKpx2rPg2ui9nFdY891VdxQnHpJFP1xsKpNPNo2OQoOSB0oJbWDZvLZLpFLUl0ErzG2/aU6i
	nVEi291Z9aaY84JwwnD7NHy8QLwuacN/vqpwubyIiYE0Q6y8AwGMAeE/R6rSM2R29q4d2KXg5D7
	QJkKpN1AxhcxGMI59NaNsvIj+GV0JeKzjkpNw+H313OhQshizXl9AcUnSeJfRn
X-Received: by 2002:a05:6102:cc6:b0:5ff:1cc2:aa8c with SMTP id ada2fe7eead31-601df0391d4mr1070947137.36.1773235395267;
        Wed, 11 Mar 2026 06:23:15 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94ecfd0069dsm495149241.7.2026.03.11.06.23.15
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:23:15 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-94dd7178d63so8317222241.3
        for <linux-modules@vger.kernel.org>; Wed, 11 Mar 2026 06:23:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKnP5gYks0iRFatYISKg9aAufHWgoWrBVJj1oYlpy2fjUi7qINSX+QgxzJqtr5DmlArJlB8/lpgUMRR/4H@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
