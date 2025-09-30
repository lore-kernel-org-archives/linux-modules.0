Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501872367DF
	for <linux-modules@vger.kernel.org>; Tue, 30 Sep 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247500; cv=none; b=Oxq67dYBB2ITpcwgHTimj7LVuyLbhhdYrqk24cISRi3OoerCFjRgv/0VLZvgTCZUC3CZMSeZAbZFaYY1A4o4zPvICGd19VDQu6qq2/uxLTN2yPLWwqq30m67xlbB3cXYQRzO3PjueN3eKSYp+KgAFoQRi1fL/zu+Nf+wPFDNzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247500; c=relaxed/simple;
	bh=YNgK/31s5s0p0awoShixTkpKVHtAwCcACffZs/i4vJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNWGjmcitVEVjmnMyXSsfF97W3uPpYwnaa82kce4peQ5iYpLSA8IKYr9uAGe1EsgMRVnmgXB8Mted5T4g5R0BzlZYG3OOwlzAWgeANvU/kI54vyDxltCBR7Yf5/qo5HfKq0MIMPV0zE/BpzQZ+eLo8eajUuVEawAn1bvGmFVMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGEXGqg5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGEXGqg5"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso4836361a12.3
        for <linux-modules@vger.kernel.org>; Tue, 30 Sep 2025 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759247499; x=1759852299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNgK/31s5s0p0awoShixTkpKVHtAwCcACffZs/i4vJc=;
        b=gGEXGqg5Ky66FWY3R4nxDdzmE+rGIeAQ6PEYN5EUZOWBDKTqpURUtxSn66pLSuHfHN
         179UkLimWetDHsEFK2zIq4E4zjOVOWGXWlONuCD/aevkI/8a9XAfMSSsJjRxufuLdwFv
         Jw6IkCpyYFyxpaZ5VArgkgD43ox+nTtQ1or8N8of4ojAM3JnA8nMjRSBAsQc/yRRoVFz
         vbunbO4/pPm7hAcmcAc2C+2TlofG8WVv+Fm2EN55okG+mvIUxGlwcQWNpLMoVqVZmHmi
         Skr/0oTlu7kK+TdXkofiMpZgLHWW2tPy6wpPZ7+ob9ErMz8Z2PmWnBBDJrrHg/OSmXyO
         76HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759247499; x=1759852299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNgK/31s5s0p0awoShixTkpKVHtAwCcACffZs/i4vJc=;
        b=ephQue2hy86jOfhS3mIvNBrmUuxUiWKgsOOdpcqi66fPdX8TmNp4PDab5NAZYzHzql
         or98GK2MaV87inz1oaOR2sKw4FjblkYtJMvYJPWN3kpoOZEjnipnf7QI7+0sc/J3Kvjf
         ImwS24II5B5kMAl83NzOdcsgh8SaGIsykGBRj5EuowF8QXQeMZRogxiyKfNgms3WQrA6
         51ULLYRDH79gxytXnLfQoe4pepraGPj4SonwNvI7x94odKHPKnr3E1B/STUjEN4E05CV
         Stwbst1+XUJfdQECMClK3rrapaYmyT3KB8OsTvkGc0PMb/qJq2sNoDwsPpqz700UgahM
         bhYA==
X-Forwarded-Encrypted: i=1; AJvYcCWHSq7yQsG9hRTAcrjAGRABIcqF0e1b6B4LlOxPHV72sezXWfLusH8mhdiviwpaMyzDOCzt+wsWFdsVH+XZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMgA08FWgqx8iTqSpebH3gfOYabNWuqsJzJl1PaHQ/0qciLSlZ
	bwABigmPQ13Qyciy3wAtrj3R0pR4zF4qPHN5MJgiL/fDy3lBADWKFaspgQwy3HFJDWLF8vCL03F
	VZRi5TaK7qN9RVsjZQ2jCQwqCSq6UoxU=
X-Gm-Gg: ASbGncsZ6dqmgRzyXbLckS3hDWytGnGRs5SYJPW2C3UGPHf1R3T6x2f4ilSCzcC6Cd4
	7UdYOlsMENPAgauN1yJs7YEFM35ZV8M1PDHGE8vBjpbQgaChI2nBlx1nAL2UbB/1YTR4Ii8xSkN
	AS1WzK21Su4QDH9Q+uM5x9S8zSKjrLhglbhtzS0jsyUOXt2324USS+fTAAy94DBs6hdOmPuvmew
	lDWEocPm3W3cHSS9ekCV7xRtROZ
X-Google-Smtp-Source: AGHT+IEd0NJC1p3y7aLeiPJx1+PX7i0RFgbdfPr2KJK1dVlUcF/qgUZVmRbRgJtGMCSJCbx+OdCROi7etv0A4qnVF+g=
X-Received: by 2002:a17:903:3c65:b0:269:aba0:f0a7 with SMTP id
 d9443c01a7336-28e7f2772aamr3321005ad.2.1759247498577; Tue, 30 Sep 2025
 08:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
 <000808f3-10cf-46ad-94f9-95a142c08b59@suse.com> <CADuX1qJZ1V32d0U4hSOUOzte2KE-k-Hzop0zZd4=7Ap-kS3JzQ@mail.gmail.com>
 <3fc3f7e8-3297-4586-91ca-41f07c8a9418@suse.com>
In-Reply-To: <3fc3f7e8-3297-4586-91ca-41f07c8a9418@suse.com>
From: Julian LaGattuta <julian.lagattuta@gmail.com>
Date: Tue, 30 Sep 2025 11:51:26 -0400
X-Gm-Features: AS18NWAQdWpu8g2kC6qAaXYg8qwcCOJO281YwGwhZqyRvLU9GMiLhjffpDOQz88
Message-ID: <CADuX1q+_U6b=Bsjm1AxbabUsao+BEk3wr9ZeZHx+N0Wnkr5TbQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] module: enable force unloading of modules that have
 crashed during init
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you so much for your well written reply. I understand now where
I went wrong.
Have a good rest of your day.

Sincerely,
Julian
