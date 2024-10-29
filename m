Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE4020C001
	for <linux-modules@vger.kernel.org>; Tue, 29 Oct 2024 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246007; cv=none; b=CFnelk/fSXTB9m6Ihqa2+CQ5QzEjCKf0UCPTN7p+0sM2aaZXTRNBAbTOjR1v1sf0yMYQR8kTT1gtUacKNa1rpi0lJt0QnTd0mg+SzxozbXQ7vkRnVJ8FmkdtL0vJmWyHGvBWb6Nkq77l+M7qtS4Yp9gfAAhnvKflbHzI2mPE6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246007; c=relaxed/simple;
	bh=BiCabWdS2vxLBuw9FlQyB8b+KJNojmOugixJl887czU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/E/6XhoEgkPsYth5w7AIysXn2aesA6ncsyNGU6RP0BvLLJN15S3DQWp3GKLXSqs3j+Ex+FCXtw/2vXiucr6231aoAJ0Mv6F8wQVp4Ib9sjhBkPnEURtESfBaXU5/jaaRVJjxzZ+rDrWuTcSsl1P53GnhU7l2rTvWKzrdVU05y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0tDBdDkM; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0tDBdDkM"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e681ba70so7766e87.1
        for <linux-modules@vger.kernel.org>; Tue, 29 Oct 2024 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730246004; x=1730850804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiCabWdS2vxLBuw9FlQyB8b+KJNojmOugixJl887czU=;
        b=0tDBdDkMnL9EyJr2hKFliDpYWZJxcm369Z+BSmaCCloF0Gv2d7ObHM/tKc2uLSPufR
         H1jvY849eR/Rr2+3+Uqyu2LXBxTljEUX4UeXUy4rn1/9fyET1I/XnP1fi7F9TKfc6/my
         0Oaxk/mW88T6GFvzHPRsCQZsN1dTjbhkA1Dh2f1eHyclo9SBTSqA/TOybLlcrRV3QulR
         wtHv0wATObHlh9aqVL7E7OQhBLtni05tuKLo8AkJwfcMM2l/4peLvo0NxT8SUSMvDrW1
         5t9DSAQCALZIs1lkEI4C/Flj4gt2e9auL/bH25VF2nJgXsn+78TAx4YBDAlFY49F+O4H
         MBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730246004; x=1730850804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiCabWdS2vxLBuw9FlQyB8b+KJNojmOugixJl887czU=;
        b=fT+b+fOX8ySF6hv/XU6G51V/hkyx+ClSyDfz/JbXvfak7bPiWvrMjrOYmsOPdJumsJ
         ne/Z6qqutyoMGxBBT0cC21TZ2IRcuB87eUJu9mPBNH4BXM2bWvklxZUVdlfw1znXpfCh
         KEFu28tubF+6kdKxS+T3uqC8y+/20qV22pWeURUREbbxIJGYA3ocbsrzi78Wos1+DaN+
         F9XiMyIiN+Fb13jOM0HE+H1pXpN4dEniWSXpfURme2/Dyy8Q49lVsSnnrLmnojipFnyL
         FPPZH1zn6WI85NDZSP8Zze2VIq23scsv4z3W7NXdg0tarCkX7W/i4XDt3qXnUKW+RQBu
         +SnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV86vla434+YIQwv2oYhjQpVxfVkmeuPXxCxOWKYAaBYlPwDI0V5prIPtB8HxvXne12CIY1wuW3jwzZtLv2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6AtDzujgV/5cn3OStgI2KW9Z6ph30rFcnTQNNJm2ldkasEg8n
	n82VlmegK0mv9tWcJRXHl+yrp9CLq6tGfYQUrMIBS0nu66NEWpMqV30phqL0x0q3M4AFqff658g
	JcDgfOUqzJXxsGAExxGnIKpFp4ZMXH6/k3TriBnvvt0NbqgfTHw==
X-Gm-Gg: ASbGncubcsTVhir1qafae4shfsZIhOfwHVDAl6oa3GTLxCVgly8fCRgjyJsUG8frH4w
	jJ5Z7Z//7XyHM/5GUzdkVcVyTM/9f
X-Google-Smtp-Source: AGHT+IHIQGDElLz8/qVf/OV7Pyn52bxrEmCudJB6RD46Ot+/aEOB2whwuA3TpN813KwxwWMUhrWTyKpmffCC9X64vLM=
X-Received: by 2002:a05:6512:1101:b0:533:49ab:780e with SMTP id
 2adb3069b0e04-53b4804d6b6mr875842e87.2.1730246003424; Tue, 29 Oct 2024
 16:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029-remove-export-report-pl-v1-1-9cd6ccf93493@google.com>
In-Reply-To: <20241029-remove-export-report-pl-v1-1-9cd6ccf93493@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 29 Oct 2024 16:52:45 -0700
Message-ID: <CABCJKudHknUxbgHBX9kXOkyMEKn5VrFsLZ6u95fnqpngp4Wy_w@mail.gmail.com>
Subject: Re: [PATCH] scripts: Remove export_report.pl
To: Matthew Maurer <mmaurer@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Tue, Oct 29, 2024 at 2:12=E2=80=AFPM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> This script has been broken for 5 years with no user complaints.
>
> It first had its .mod.c parser broken in commit a3d0cb04f7df ("modpost:
> use __section in the output to *.mod.c"). Later, it had its object file
> enumeration broken in commit f65a486821cf ("kbuild: change module.order
> to list *.o instead of *.ko"). Both of these changes sat for years with
> no reports.
>
> Rather than reviving this script as we make further changes to `.mod.c`,
> this patch gets rid of it because it is clearly unused.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

Thanks for the patch! Applying this separately without waiting for the
rest of the extended modversions series to land makes sense to me.

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
