Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347220ED
	for <linux-modules@vger.kernel.org>; Wed, 24 Sep 2025 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752227; cv=none; b=K13yIwe++p01+As1UYBn++82hYOB3wwmuJoh8DrDkg7tJy/6iLh2K4Ko3TCWXFn19nOdf18LKffZrOWuq3GLliuCAjRyjx/GGxAM9Yh0/TCXe/k15esMyyrqx1We1Ir5T6i5CKeeMf0/0VkMcljqBnz9O/sUBg7Sl8nBlGyGmpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752227; c=relaxed/simple;
	bh=BU+WCA+80wupmR3ABcOoM9JcjfSnFaN5GnaRcYFKGKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+Ef2gmn9yRCvkNSHCKlWh6w0m2kU8NeQfyzGqq1JTKdyWfP6jGeXAdHCk2NSJ0Nm1zqQGcHE463MNzozyGuY4nAHpTl7Rd8uqaCSHgMpLx1vj+9GSuyzGCKAUqh2szs0iyIuCQSnLVSLgIx6z3NOPBG2CR1LapJhdGHAxgrNvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlj1xJo9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlj1xJo9"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26f0c5455e2so2952185ad.3
        for <linux-modules@vger.kernel.org>; Wed, 24 Sep 2025 15:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758752225; x=1759357025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BU+WCA+80wupmR3ABcOoM9JcjfSnFaN5GnaRcYFKGKI=;
        b=dlj1xJo9wynkw217fSt+MNFgZyZXR3BPYiDGYYwdybK91yaKy/DZRomuMhFt8zNml3
         F43Iy9UZcXPt5XgNxaZRc8uCEL5MSTFpC0yRXgAAUxylblXGRDVbon5PzuLuMZDu8ke9
         JTHq3ZkAqvHEyCqhLTQHiQ1e8kSw+qQ3C1OVRi1bpBbQxmslnxju+HOzXB0SFz3zO5pN
         oVB/sz3157ygjPfPI0RduGIWAnV22K45GUr3owTVK9GpmvsXJTVJnMwgQo27xrKUFyaN
         T0sT8pEJvGSdDvu0Vgd7FzFWDLtCJw3yOteBrNBw8V+CxmZiPVDBYK62sVOj+ryhdRHF
         kODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758752225; x=1759357025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BU+WCA+80wupmR3ABcOoM9JcjfSnFaN5GnaRcYFKGKI=;
        b=GaPBvqxdfP338Pwb2lneSFBk9POu939fsTLy9KWWDDeP8lGEW6WEfZgyspr1/FdR2b
         ViBGavA6vL628/qjgQRlYkDhTw3G/b3HLkNp+GKc2ntnrlyjo6Ch+cxeg5kRRk5J9h1x
         RXn2802c6JtCLlCUZxLdovbq2+73VXDhIZyWlDbYuQpxntSB940xKJBaXJHoX79/rwkc
         P6VCBVByM59cyRoYOdRCu5IQ4saEjcYEydPlp0M8BrVhGtNot+idihliOKKmY/EUM5RM
         11n8KCXCHaXQZAnkwTQsJuuvixPDcq2HmkOkb9i+knVreBNhbX+ri3Ud23uTjwWZyoWY
         vJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCXBV5sEvDlHNkSYeYwQfNVA4zkQgGnPMpdSm2MYgI4yLsnpWTYO0klafl3b13+1Mb0EqrkcT7zqF5GoKnWw@vger.kernel.org
X-Gm-Message-State: AOJu0YwFLa4oRp9pvCDo/GRofhSIEy2n6rb1Mx7uGtfr3IVNXdl8VOI/
	ufwfPO5+AJp4U8hWN8TGa9eKexAYAMZ54VC58Q8g/IvKdc7Kita8RSMArXXu4Zw0YbbgSIB06qz
	45wL1wG3TJf0Rm4enZcNn0B9Vr+gjRqc=
X-Gm-Gg: ASbGncvhl9U1BnoVemoXcZjcsTLIruYshBYe9QpPpERAddx25XFWl2OHmd51alcN8cY
	R/J2u3HcpmMIXDZgYy7LSfWDYmiYBcdlqD8CDrLbH4L9ELI7XJRYJcZbnW7TU8/9wqHlLfgrM1Z
	g8OPlkfkyjPLmLQLyNoiaiWeZqJ4kq4gPeQES4dZEpLS3HWw69nPpa2fXuG3HE0puUMPTcFfwPj
	AGF
X-Google-Smtp-Source: AGHT+IGLga4Nd275V5VJ+me2n4+cweQRd5SaJpr3IPBvldnFR3TBBvkIVeIyqT7wP6rW+eYpEw7ocZ4oYldyXDIWVeY=
X-Received: by 2002:a17:903:2442:b0:250:999f:31c6 with SMTP id
 d9443c01a7336-27ed4a3165amr11107805ad.32.1758752225112; Wed, 24 Sep 2025
 15:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918201109.24620-2-julian.lagattuta@gmail.com> <000808f3-10cf-46ad-94f9-95a142c08b59@suse.com>
In-Reply-To: <000808f3-10cf-46ad-94f9-95a142c08b59@suse.com>
From: Julian LaGattuta <julian.lagattuta@gmail.com>
Date: Wed, 24 Sep 2025 18:16:54 -0400
X-Gm-Features: AS18NWDEw812FHiWYzAMJ81ep3O0jjDYxHiHcGHIsuEI15DM2GSEPmumxHFcyYs
Message-ID: <CADuX1qJZ1V32d0U4hSOUOzte2KE-k-Hzop0zZd4=7Ap-kS3JzQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] module: enable force unloading of modules that have
 crashed during init
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Could you please explain the motivation for doing this in more detail?
>
> I think we shouldn't attempt to do anything clever with modules that
> crashed during initialization. Such a module can already leave the
> system in an unstable state and trying to recover can cause even more
> problems. For instance, I don't see how it is safe to call the module's
> exit function.
>
> --
> Thanks,
> Petr

Thank you for your response Petr. The motivation comes from when I
wanted to replace a crashed module with one which does not crash
without having to reboot. I looked around and saw some other people
complain about it on stackoverflow.

I thought that if a module crashed during init, it would be in a no
better position compared to if it were forcefully removed.
Therefore, there is no reason why this shouldn't be an option as it
couldn't make the problem worse.

I agree that calling the exit function doesn't make sense and so I
could change the behavior.

That being said, I understand why someone would be wary of this type
of change; this is just my thought process.

Sincerely,
Julian
