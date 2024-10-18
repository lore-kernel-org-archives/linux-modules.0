Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347515666D
	for <linux-modules@vger.kernel.org>; Fri, 18 Oct 2024 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243531; cv=none; b=ZyALApgkWiOejNXrtzawv4+PXnuOHQmD+C3LT2sXn/oaoD8dlIv+Su3x0qTljkCYFRaDw8Laq4UKPZp4c+URGlrg2wWxyx4DZMxTkoTz8H8TAxMgzwAsr2V3dYcj2jdyb43xeDbeMUbqFsmf0qvZEJdCwCXGLMgpQ9DV04GdDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243531; c=relaxed/simple;
	bh=KkdRAlUdnAkapsvnp4nOTHfZKcVquIjbdKE/K2iQIMw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bxM8kDiHy0YRTZ6mVBizGPL7PgODUZRy7grOvaPt5JzUs0hUTIUlbL9woARTj13GE5HCxyNvMqxTlLrGC7HeMXxb3Yr8GtPJdmgBoiUec4AEPsQqXSbCTzRbkhzG6uI5Z+pnpQ9xs9lRuuJz8HcDpWSf5LiDE4gTYEciv1WBwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVGBv3Hv; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVGBv3Hv"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f8490856so2255480e87.2
        for <linux-modules@vger.kernel.org>; Fri, 18 Oct 2024 02:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729243528; x=1729848328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkdRAlUdnAkapsvnp4nOTHfZKcVquIjbdKE/K2iQIMw=;
        b=OVGBv3HvRna2Sy9fozyObD27xsWPB0EFLs+nlmxtv++/yD6vanT08yrZBCnDeSBQql
         Vuden0f2xrSEKv3NfyAGwi1q4xhVtFtY+VnzvkTB/qHYN+x5aHpm8tJs1WmMB3UdTKzy
         a/CBGJc9ePzWL1jYblICOAT4I80HdNf5DVXbpJfRkAuz3xVbQGhOgr0Mk0moI+P3NxQ4
         BkeSwOv2/AqA7BbmEVMBHi87MX+nRL0FZCqAcDdauIHGY3bGGggSiKuNoDcEdg13frki
         Cn1aeu/Z21ey3vDQolffpRNS4QsxTmsSWjHm2L/+ZVxmgpkaRlrq5x4XideLaQM2J7Ad
         Uljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729243528; x=1729848328;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkdRAlUdnAkapsvnp4nOTHfZKcVquIjbdKE/K2iQIMw=;
        b=lBFUlWmGddYQOcIvQ+wOUUCDFZs8UpXMRFdfPyr/HKxZD1sPtFOoiDYelEs1vFvN5Q
         il4oeNxP+nvpc8RnD4QWFAuBrlcKHBJ7kK8S+4NIgRU61C6wPJDxXIJ9Dc/Gkd5LzADZ
         AGxZ8JCcGUH9zdD39w7dZQr0L5D64c/qaJnhZWsn7MFA4OqDSBP7/gU5WuD4Se+Q9hnJ
         hv2SNLFWvjjwtGcl6fIbNG8iPfvRjzTd6xbmCsLZBfR81+EFcVoMoaUfBAXVuZeKKS0L
         P7WVwHINxb7SmPDptLUQGmqPIvu1itaHdFugP+wqVgCLnPiTbBzbjYzVmf/D+0V57JLi
         srhQ==
X-Gm-Message-State: AOJu0Yw3AU4Pj8Pk1ba6W6ja87sEghZVORPjqp0alDS7LDmcrPXOTu/a
	ZsvwFCBebQipps0TPL93+LOZRjyOPTzP7ek7HfBBLeB4S+UDeRZFRf2oWL7NASCcdoyQG6op24P
	OjcPu7kSYOcPtgizbKWq5/7CkuXOSK8ZR
X-Google-Smtp-Source: AGHT+IEP0m/CaDGZ49fwqvpxHSNEGpVqbT+yjpsuVp9OlG0bUs/SpZS/GJ0MqVAMpPibIGvOMKN2itFj0dKT5dxmtJQ=
X-Received: by 2002:a05:6512:39ca:b0:539:f371:3279 with SMTP id
 2adb3069b0e04-53a1543ef76mr1067655e87.7.1729243154703; Fri, 18 Oct 2024
 02:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 18 Oct 2024 11:18:38 +0200
Message-ID: <CA+icZUULLhDyScuQnM4Tx+JD9xMFhnKVkxepUK_o1jGhJGo+bQ@mail.gmail.com>
Subject: Status next kmod version 34
To: Lucas De Marchi <lucas.de.marchi@gmail.com>, Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-modules@vger.kernel.org, Tobias Stoeckmann <tobias@stoeckmann.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

thanks for the work on kmod version 34 - still WIP.

I am here on Debian/unstable AMD64 and would give kmod tip Git and
meson build-tool a chance.
My last kernel version 6.12.rc3+ was built with LLVM/Clang version 19.1.2

Is there anything speaking against a try-out?
IOW, what is the status of the next release kmod v34?

Thanks.

Best regards,
-Sedat-
