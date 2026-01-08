Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FD148AE31
	for <linux-modules@vger.kernel.org>; Thu,  8 Jan 2026 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881421; cv=none; b=OjlICjf1qswMhK8MdwMxGVEr7UGwiWiJo/MMkfLt2vK3ZmTXaGVrvWbkM4VgMrmGm6ov5Mf07105McuoDKB69sgE4jGnKP2xk9LoubWb8tC0VAjbs4R5/6fysaP9xZ0a/8mbYkfm41f6g3XW/that5IqMDThPVrc/ugIgy/HPQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881421; c=relaxed/simple;
	bh=j3o37ljvU8WW3JLmg4pFonRiNxJi7xTRwgos4PfkORA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOSts2gdJy1BKyq4h4VRQfV0g7aGnM+vZu67dkT4L/XBAH2/C4ewwnLqBfJsE1jIYcynk1s2BTLzqVpDMQAUdDP0J2vjiqFpuZBVp7USJXxh5YY+0z9Y7QzZB2VSL5JU1qvzXHIVov3eTbRrLx4eOBwZx/i0RAGy1m4pM9+4zqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpeA1Jns; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpeA1Jns"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12055b489e0so255786c88.3
        for <linux-modules@vger.kernel.org>; Thu, 08 Jan 2026 06:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767881419; x=1768486219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7jDvUFCjfFtmadOVjljTYdbYZqDf8COd2PlPO/Cyo0=;
        b=cpeA1JnsKQUknZFaVdON2sr7SjXjkEBc7nMnIArN5iF1m/flAOnokYI68BAfjrDe2Y
         6ngLp1c92vrcFBrWycvdpYDEA2DYQqHuRg7CY2BUdrb0lcDkRt0Ac9CLJZgdkR0kjlN8
         +Ww6zafbb9eVrvuMUmWN6Cd/liR0cGMoQlbE6ZlnG4SQLoDIgL1x/oF7XJINpZccoNfR
         RJgWlBaUVTcHiGmjQWvfLtaNNZTx5pySrf6UB/XowLYxeVbmTr+Dpuf35piJ0Gikvgk8
         EtUWd09e7jFlEp9UaMZJ5O+f1zjvfZrqZAjBf0ru85glge9ESAVOtsy3yAucgIxnFL/4
         WTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767881419; x=1768486219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f7jDvUFCjfFtmadOVjljTYdbYZqDf8COd2PlPO/Cyo0=;
        b=FJksrEjSPsR8VNuUVBbZ3T1Wk8hQlnu+Y3nNZZswxhoetyxogSjNQ9YKwsrqYj1PWM
         YPifR4jyHrZlSZrrlhqgkqwcjiKjfi/09NrWKA399Gm7sU8ZoaQAbnKkAch56uIRqVEG
         kJEcyZj0BFzRU1jcWivLyEcrjvnlbSkvWej4zEC+7hzhUflfBr92D9/UNs4IAAmp5AX0
         qXO78aUYjyGQuGgrG9XuZ4XI36ZBwPldrKGIRGgOHc5HdXGvRe1AQeZcGF9iw02vwoie
         qZzzSux54GzFeaaclquGF60F2FT1u7AXch7H2gNSiSjzqljJmrm4svsUCMyqE1cdLIqX
         wSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF9JtbPl1nP4c/If4el3eaRbhLjenr6vuVNTX30wlvigLOIJkei/EtPccH3fFDyslMin0U3xsDN4dbvDCh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jdmcs31ixde3NOg3NbNQxgoUQElk+/Ivd9afKEOQ1fuawHNV
	bwvnp37RjWa3IOsbbMqomJltNcqmhza3fIkdZOBPkYNHrkzRD4oN5Ikvq5+BMNQ7T0BNVHrIFS3
	UoffQW4LuFsStUGOm9EfS4AkK8fC8/rg=
X-Gm-Gg: AY/fxX4SIqFGQ0YfgOsFfqtI6bPbDeVhnYBriMBYt1XmMxVhYg5AsquGALdIPTazpDK
	o8zjxZe9WcDVbxgZJWe4xTXdDH7rL0vne9I2SPqi3BwHDlDDJqxQh/Nd1BMlT49rZSFqGp9JlDj
	RBjwWiB0wNxxMYeS3rKJo9QEXkZM+Uz1T0xXn60s7hMrErilceFZl+U8iSntqfq/tUOiMB5AMNO
	Mwh3Be0YoSFi7p6FwVsdeKwpSpmbamDzi/cT0bXEPK6qphftL6H3xiCApqKzrOrBuYOU1vs/xlB
	Clx4x8PzMDQON2TCkQ8ea3g8wEX93ts1TcKHJebtlz9dMRqA5DOW4YgZpRlluAh7E/qg6dnwFzp
	MR+6U9xXTSyHL
X-Google-Smtp-Source: AGHT+IHNeMjlzueJHkJLbN74lNQFyQb0gOywPBPdlNCJT8fAFTRMjn3wgKYlbOnJAnxGIEInLPyC5bkUa1Vxsxwj5dc=
X-Received: by 2002:a05:7300:dd0c:b0:2ae:598e:abea with SMTP id
 5a478bee46e88-2b17d30fd2fmr1936203eec.5.1767881419200; Thu, 08 Jan 2026
 06:10:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-documents_gendwarfksyms-v1-1-52b1f9c38c70@gmail.com>
In-Reply-To: <20260108-documents_gendwarfksyms-v1-1-52b1f9c38c70@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 8 Jan 2026 15:10:06 +0100
X-Gm-Features: AQt7F2q2cgHdJNNgrL6_JC_APYg1zxqroIvS3FffCSeaIG9gIAOBm2Oruoyww_Y
Message-ID: <CANiq72k7_Vys-UxF=34eouu=CquaTXcb=jMiTwVb8mhP=SGEYw@mail.gmail.com>
Subject: Re: [PATCH] Documentation/kbuild: Document gendwarfksyms build dependencies
To: linjh22s@gmail.com
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 9:45=E2=80=AFAM Jihan LIN via B4 Relay
<devnull+linjh22s.gmail.com@kernel.org> wrote:
>
> Fixes: f28568841ae0 ("tools: Add gendwarfksyms")

Not sure if this is meant to be a fix or not; but if it is, then Cc:
stable should be considered since that commit is in an LTS and a
Stable kernel.

> +Dependencies
> +-----

Shouldn't this be the full length?

> +    sudo pacman --needed -S zlib libelf

I think these are supposed to be a tab (at least this file uses that)..

Also, Cc'ing linux-modules@vger.kernel.org as per the "GENDWARFKSYMS"
entry in `MAINTAINERS`.

I hope that helps!

Cheers,
Miguel
