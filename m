Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12463C062
	for <linux-modules@vger.kernel.org>; Sat, 10 Aug 2024 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723306160; cv=none; b=JT2alFN0kAOghUcpk2VH77zbCcfRSlZKjWiewaW71Eoh6HaTtWFhhpLCb2cKhlfUchBVxvPAp0A2ntdMo1Bx2LhD4CwXlfQMPGgaVrSY6cK0MxlyKUHM0ntr2y09CPuR5+zXd2QR71IEtmUHoDoG+EB/A09iKduu3SsTiWEFKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723306160; c=relaxed/simple;
	bh=dZreob/C2Dh0OiJTwgOZcHi4rPQ/ybG39UlC6oKjSNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7s5TByNGk1bTjfMwlPOz7ETkaKOyTNYloNdF3/9i/i6qfDfmalyrCnhIHgtwOtqnOoj5L/0nHnp8B+fjC3o1AW3kIJ9cpSiQDKulC17I0cb3J81lozfWfuECROnwT1v5HwcGipNhsh6YPm9lgmWGwp3QfaP3epvO944ScWKCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHpf0Gy6; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHpf0Gy6"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b97097f7fdso19062666d6.0
        for <linux-modules@vger.kernel.org>; Sat, 10 Aug 2024 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723306157; x=1723910957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJl41PUahpsS88SJFbu5iiu7Pp+n0YRGI+XVpFynndM=;
        b=RHpf0Gy6xiTwTuQ68oATdbmDdhzi6XOkNNUfmLA8vpxLD/IezmtoJC4ltUOt3SY4dl
         ldbpfJkyClJbZS4a56Wdtlp9kece6p0d/Tr9p4JfrerCRPZ+dkK4kyAcJD8bmS8vDohq
         2Q7+t7ipUvLCLsqAgUW3/eN2a7ule5BiP9jxJtuYMfLDfxas07GZ44kqlcfXUyALc4gC
         ESM60z5LLtVOopGs5b0e56RXrPNH2xDb8UctpVq/RSr3eesX/G8rFf2QqDnUMgxkDbur
         iyhhu0Rcef7BKousGG3DH+UwVeBuLzJYF4gKKarSMIY3DVPk3I+Bift+YGbo9g0VNUYL
         29Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723306157; x=1723910957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJl41PUahpsS88SJFbu5iiu7Pp+n0YRGI+XVpFynndM=;
        b=eCkSqiLLLoXSmqlfXJl+IuGpACPYXXsgzF5XQ86IUOHzNTn2NzecrDQFc016Q8oX8E
         HlbIZEEiY24FBD7H/3JATVzRlLdj8Q7mwX69SFNANhaOKETfSZYOKDp069HWmsRbNKbc
         CyzxhMead059K+nPi9x7eQtLONBoUIZ83u+5g2onAKICZd8ykIH9d+mA9P55f3KwZ0W6
         fqmRv1zmt4Org8iMvoF+mQG0QvENxGFiKlaMh+RhitP8B1MNaASff8JN1HyhF0DVBJCo
         2xl0ATvWQwgd+yQ0YbPdkMGE4Pz6AHnRZndzehykknd/zMWaI89Jg4MZ6JcboRClbX6P
         mNKw==
X-Gm-Message-State: AOJu0Yx7WPI73hVTK6YKyKPVySzyCOlW6vE1ta5p0poOit0eSR3tmV5Q
	RM9PyHCOfGdUYM2bkx360eZ66oSvqNCgDravkJQ9fUsirNyvvuvROk0oag==
X-Google-Smtp-Source: AGHT+IEu+CL4nA5E5VYh/WIt3F/p+2+WtcPqNRlXmNEyZxz2p4eAGwqKvQTcjRyZF78q3wjWwaQb9A==
X-Received: by 2002:a05:6214:318c:b0:6bd:69a5:4fc4 with SMTP id 6a1803df08f44-6bd78d1d481mr55944906d6.8.1723306156948;
        Sat, 10 Aug 2024 09:09:16 -0700 (PDT)
Received: from ldmartin-desk2.lan ([134.134.137.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e65c15sm8091186d6.130.2024.08.10.09.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 09:09:15 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org,
	Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH kmod 0/2] Couple of SPDX fixes
Date: Sat, 10 Aug 2024 11:09:07 -0500
Message-ID: <172330613666.229774.5993123078340385331.b4-ty@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240810-b4-spdx-fixup-v1-0-b9c84d637fb3@gmail.com>
References: <20240810-b4-spdx-fixup-v1-0-b9c84d637fb3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 10 Aug 2024 13:25:14 +0100, Emil Velikov wrote:
> Seems like the revision of the SPDX license identifiers, that landed in
> master, dropped the wrong hunk/paragraph.
> 
> Namely: a function description/summary was removed in one m4 file, while
> the license exception in the second m4 file was intended.
> 
> I've left the two changes as separate patches, since I'm not 100% sure
> if dropping the former wasn't semi-intentional.
> 
> [...]

Applied, thanks!

[1/2] m4: reinstate CC_CHECK_FLAG_APPEND summary
      commit: 0cdd9847206b368800dac9099d5af2332340a0eb
[2/2] m4: remove verbose license exception clause
      commit: 5535278c8d6e05ebc9b5c413d495c155a8c09bba

Best regards,
-- 
Lucas De Marchi <lucas.de.marchi@gmail.com>
