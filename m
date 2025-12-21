Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C02F999F
	for <linux-modules@vger.kernel.org>; Sun, 21 Dec 2025 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766321572; cv=none; b=BxuWgFIAHeW8E2taE3V20fDYnW9yyhpq2XtGnoCXNKalQqlFrWEXTR1wafWOWP8QczwQ4vHidencaaCYEOii/9xR/Bks3rrl/Y+wKRC4oCDobxfu3e7kP2st+DRqHn7lIXOwEblS+2A/TmoyYl4SXM/3n/ngePp7YZX/a7PUDcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766321572; c=relaxed/simple;
	bh=zVC29AsLXf0qaODbTFd8HB8zOYEu+UQOKW51j3CD2vI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GZaB0HykjOrKWhl3Xj0v+UnxMsdtApoc6lIPNsJS23++iw9nx85WRsvn+qLSoJu5Jgt4xOAIC9fE2h0VQRM/H4ARxqnkjBGiqtNAqMWPbb3Pa+jFdUvZn8CAxKUtl64oYya39AtVNcOVTsF1EPI4z/Ufjqh0B7rlHD6tFCvOtGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOGySFoG; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOGySFoG"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37bac34346dso23278531fa.2
        for <linux-modules@vger.kernel.org>; Sun, 21 Dec 2025 04:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766321567; x=1766926367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ewssAqo1bPMzymAusjyvh6QxSKjWGYqx7PGPNjLSgIU=;
        b=GOGySFoGkponMKzPW/WOa1yMT2Fl1UIbaHwqkZQGUn5rlWKcMEArVSPqhQfym8bB4T
         0SnvbDCJrNf2qaEE+ToG6wWYxkJDtgn24yTNzTTP4LFoJj4dLxUF+GiJnn1XV1ttsRBi
         x2ErD9Tsoq14neI+zuwSLlsJpxSNS7TVQD22KLsXFnTndpkdPoyp1hGYmfhOVGx95j14
         QjudEJhl5/0wyPwPzXsmxCH/0y3QeeoZR540qXVdAWJqx8VUHNOblcDWnEvC8WiC8E5R
         a4vbm1JgVNK4g2ceWQH2+DRz21yKnIkD2u/oUIVLQ33luMuz14R404rT+AX8Fq9zRARR
         VjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766321567; x=1766926367;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewssAqo1bPMzymAusjyvh6QxSKjWGYqx7PGPNjLSgIU=;
        b=rENM8Pkg6JTA4Ib0SpC63AzdGBryez/URyEdK3hLp8o3TFCj+DpD0fw3XpXOhBYSfB
         zfp/5s1Zee2XSBOBOFV07yji2oxe4aNNgxPvXrdypr4F+zGgha+h5Io59I7GXV5KPFPy
         M+W56Nk3dc5o/+6oN/jRxIciHe1LzwM1PZuBi2wn8hPyYCcNDLdMKg47EKp/CrknL4EL
         WAdJP1i4WNkVZoE3/xAsCHJ07BKHpnwSac/IzbmMDCdQ2v1SDB+sDhiruE0+tUHiE9Kp
         5PmU5gQtqm4MJIP8GmD2B8sEjdr13TKV7+vhWhF4wLFwPd5ks6iRUHsTdxlFpvOwzBH1
         eTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWct+aAlgDrMxJQ48DBdNgUDhxHBDOtyDZFoYI82WfwlP3sOlG9a+gKAD72f94B5AI/kSVSVdNprKbLm0g@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93e4640Z+5whYV5B6BAVYbniayFt0ivusMqyUcMv2IdD6Q7dv
	RW9mVzuAcmTbvw+ONwwAI/MX7HUmW7eTXNxy/tTk2UNILupGwXebB2k4XLo0a/BsUNU/1LcGQLD
	4wF0QQzeQdNwIStbqcAf1u6ROJ1lrnmk=
X-Gm-Gg: AY/fxX56jlL2w7/wGLVrXYxn7RjBKInnsNXu923iBi01YpklKEGRB3pp47sczdOipxt
	6QgkZFN3Ud6YxwMh5397zmIenv0LDsEomFZE07i6HUucL0eXRWhdrNRq1LH6eDLN3RRXqfZk3/a
	BNuvMeUiFv4Xsw8PfPqBj5M+Etxf6za5TrEqVNv0XHTdzXxD4DWOFt/e3FyV6xpc5yYZFTAW65h
	3n3ACat4iJ4zc9nYjNx/XMGr45aelCnBL6qznB81KHUhSqyj1MwUF8elnh+/f/kUrEA9QrR4P6q
	vx41
X-Google-Smtp-Source: AGHT+IEz1iLVManChamvexcJptkdsdYqDuiRiS/tcdKp/m9sHolvLmbS9HUwX1CEsPLoNcn+Ljet7ExEEBEoysZZAFE=
X-Received: by 2002:a05:651c:2123:b0:37f:a216:e443 with SMTP id
 38308e7fff4ca-38121566b5amr25348901fa.2.1766321566850; Sun, 21 Dec 2025
 04:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tatsuyuki Ishi <ishitatsuyuki@gmail.com>
Date: Sun, 21 Dec 2025 21:52:35 +0900
X-Gm-Features: AQt7F2rTEdNQMItr2qx6Dugn0XBR5xsWw3SdLVnNTdJsQP7G9u1_vH5-H2BmySU
Message-ID: <CANqewP0+N0i8Ld+fGKQZbLg5yJhVkLTyvZKz_ZL0aV+noArsiQ@mail.gmail.com>
Subject: /proc/modules address+size bounds are inconsistent
To: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org
Cc: song@kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I noticed that /proc/modules reports inconsistent address and size
values for modules. In m_show():

     size = module_total_size(mod);              // .text + .rodata +
.data + ...
     value = mod->mem[MOD_TEXT].base;            // only text base

Looking at kallsyms, .data symbols can come before .text symbols, so
[addr, addr+size) is useless as a bound and can be overlapping.

I have a userspace frontend for perf [1] and the code currently
expects non-overlapping regions. I can add a workaround to truncate
any overlapping regions from /proc/modules. But is it possible to
"fix" the kernel-side semantics here?

[1]: https://github.com/mstange/samply/pull/736
