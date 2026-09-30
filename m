Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D937EFE7
	for <linux-modules@vger.kernel.org>; Wed, 30 Sep 2026 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783127; cv=pass; b=biN+yIaOBNxxs12wGj7Whp1BIC0vPOviPcmrEBJc0eh8nRFLZL7AhOYaomkCS+lIc8P54x+Yp4uw8t/l1Txs3HoPYMxTTq0VH4f60W+9TAfSTFNT/O8MS+nonmzhOiwK86gf5yEqugkt5ZJHsbbN01pdUQsukBHkbzVNaDc/d1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783127; c=relaxed/simple;
	bh=i6GmaXuuU+zwtj2v1bb6dDRelxF99MNSWJOfop71WYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoK0fY8zAVqf/WUPcRDt6ORIEvqpGXpL4Uyd4jLV0zLAvG2y/wi/BzkYYC4H6zg/8LUAWYzfW/jJW/p72vicYiwyQbk+jJUDt16c3fgUNoilKrjQSlHDAvTn+BT4BPyL3UzR7IvnSKonv06aSHFbkZd0Fg+qjQYGvX/lByLd0N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRC3q1U4; arc=pass smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRC3q1U4"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c99260bd9so102014eec.1
        for <linux-modules@vger.kernel.org>; Wed, 30 Sep 2026 08:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790783119; cv=none;
        d=google.com; s=arc-20260327;
        b=D45ZCIHPGyLSJ40K7BSNSZxcFHWgzLvTA0MkeV6cotbGmjsjmGsnRbyuph7j0ru05n
         yyzzYjMbUWPMrjiDx305iZunVGGSyNPjRWwamMwMlpP04LPLQt0Zmt74/0QTOEty55cL
         CPStSywCuCfiRa5UxbBs27Df0+M7CItYGVDfwoz6XT5q0w/RQ8Q7/cti4kPT8mzLDDjv
         KzDuokgUC8/wm0vTPwnw6YAB84chsCCRZt8qzmBbH1QCCmW483kKQX6YVL57C/rCdd0R
         WqOebDH28FuxTsPtySplYd3YEnq3a/N01v4IM/lhgozzwLjz2PrbpZjqOffPe0kpL2HQ
         SZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i6GmaXuuU+zwtj2v1bb6dDRelxF99MNSWJOfop71WYo=;
        fh=T1udEhWjD4Ru2pRIuR8UNf4g+CtOv78chqM6zEbVsD0=;
        b=s2/1woXJ0JY4TLts8wJmB6WJVNw/B9P0PX3Os6+kp0XjUqwHH2i6u7M7Pdpzo60xAH
         U2skmBD+QAGWTGm6yUHt3+QmpElfGjMWPr9YRuUqIsqNMRo2vO8/IbgH89fUZ8SaPiJj
         SDmx69QEBH8MVRNvHZYPhz1o9PD9LUJ4N064MKt7o9ldZozLKt4KSDTlyDKFAW0aTesQ
         gk+3EIoCIbqJXER5sCcjZCd6tRccL93EvtRVjvpz0+Q4rMbOr/KoqO09WftKOzjqLoik
         R0e9kTeP7DVsrPEimkJOr7Q6jEckx4j8wrutd3a1bDk3WmsDl7W3rHTHw9ttm3XKtD3h
         CjBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790783119; x=1791387919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i6GmaXuuU+zwtj2v1bb6dDRelxF99MNSWJOfop71WYo=;
        b=qRC3q1U4Jm+Zu721GKeU5MDnP/B/YfgcHDimuBO5GEsiNU3VKKWDkCTZEnb9l6VNdg
         2uX4rKqKKIRYnLId3f6QSACrT1BuYB+/v103uivfoG2uzHbF0YZOsIgq69yeNBh1I3e3
         HAnHMqj/wY9foUx+zI4vVlmTk8XcjO0FPDfuf+0XeGg5BWx0ousOEhzuYVoipo3y4Q+J
         B6+oL/hSVZ7tOHagecfCogIYPBI4rR8fabNJ6k8iGEETNQhY9vxiznMyv47p1Haz+9ym
         0WgLUCer3Z/1LejsxDM2pZNMPbS2DRBHB4tfobW3hNvGxxVKmqG24dXqTo/5yhxOO47S
         LQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783119; x=1791387919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i6GmaXuuU+zwtj2v1bb6dDRelxF99MNSWJOfop71WYo=;
        b=0p/AWviGbm1ybI4ySXC3oVGkrMewtMwGmctkG+fR9YEam5/cb81FBnr2Af0nANJyT1
         R5M0b6nM3aSaWeMfrs97kyc+C4UpGbCS3w9JqMiMj/Bn7rOC2fgT40UTih3SE78q1sIk
         CUYnto0zTvPoXSxDeIAI0U6/ynhyIL8RzGhIhhXSgXZb2ok/n3LaV26Jpn3evlGkKfgS
         XSneYvU76HJG0Qd2V0ufuuj6lkFmY7/uRwyibAiQwCDSfEjg45HNN3WcTa+ThIeQKdJc
         zuyiyxngKQ9daRknHSdsD5ZsTkYtQW76PufjQn4hD8nZapcv0Jjszs8kvmUhqGL5QpSW
         rjPg==
X-Forwarded-Encrypted: i=1; AKwUvBxrROmg4BPSchbFaXgeOa7EXIombYRSOBjyPe2kQ4Io2HdjEHUuW/RwfvQIsuvWOZTAAq1FTYXsYX4okhUv@vger.kernel.org
X-Gm-Message-State: AFq9FYLlKiYdMJOK6rSW7mJGvXCGR3hDLyu/3XVHmUMfJNAXUYU4XQf/
	5VarBPAEEMTCzjWOeRt3dmmuOk8sw2OJwqIgcEqxwBToKoR8k1h+45voNZqQnesVVC/Og/jOCrj
	Ca2qo5r4gXx9/emboAeSRwusCYES4lf9CPhBl
X-Gm-Gg: AYBFou1mOwX8gB1kM0uxLiKhtOoihiW/5iHyPTJff9872x32q2bTfktN/8gPCgVeb6K
	Fw1RpJi1k4MZzevj25v940rd/KowMDAz1aHDbtWBx0k5u3CJthwtm5PzyUdwU5vjpVZCW9CfdOi
	KaGkl9iJECaJiXv7rDVj2Tz3fJ8lOMo1JbM0WpWwnDRlBuSn2Qg5YERS58UzggLC5A3fmjRb/AE
	K/2jKv39D9JD6Ik4eyDsqU0B1GrrPFo0ikHeMitvDb4h5uC0jZ+gkIdFSgb0NFpkRRM/8rbrLXp
	LtrKKoZoyMjlZNs51mtjZQ3MTpjSGkWMtRcogNNf7f+sjWk+Zf1LOtxakrsgEgc2ELoSRkzAor2
	F7htnwkLWdqlrV2mWrsZ/1AmPjM0JQc55fMIdc3FM4nSrmsROZax4islEFnuXW5CwFW7jsQmnTQ
	mzMpzm88zNoSoJ3Q4pqdV7pa0sS27e5+Fs+SGxu+kG01ZEZEsj7vw=
X-Received: by 2002:a05:7300:e9c9:10b0:34b:7c9c:9a69 with SMTP id
 5a478bee46e88-34cd8795e5fmr3668963eec.0.1790783119173; Wed, 30 Sep 2026
 08:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917051147.98775-1-tweek@google.com> <CANiq72nRLF7PmqqVUrAiw_M3dYZCr9ifoo+Q4SuXfBQsAFH-pQ@mail.gmail.com>
 <DLSOH1EVCWKD.XEIME3CYEYYJ@garyguo.net> <CANiq72m=rhBDJSSPBZ3yXb_r0jiCq7f8KOy+Fs1k8SzWJUwkhw@mail.gmail.com>
 <DLSRGVBPWMXX.1LAWUQHDYKLCV@garyguo.net>
In-Reply-To: <DLSRGVBPWMXX.1LAWUQHDYKLCV@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Sep 2026 17:45:06 +0200
X-Gm-Features: AclHuK-xcuO0mR7ZCevwePsscH8hBfb4GfEBBZrYNyFBbqkPe1_OxY6I5DHFIUw
Message-ID: <CANiq72mi-9xCyX0VfgbXwvSQsfvowzOdsTGVF1HpKy_h8eHesg@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: allow non-ASCII characters in `authors`
To: Gary Guo <gary@garyguo.net>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 5:37=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Ah, that's my patch. It had been completely paged out from my memory. In =
that
> case this is indeed a fix.

Thanks for confirming!

> I don't think it's worth tagging stable though. It's not something worth =
putting
> effort backporting, but if AUTOSEL picked it via the fixes tag it doesn't=
 hurt
> either.

Yeah, I think it doesn't matter either way. I can remove the Cc. If
someone needs it, we can backport it later on.

Cheers,
Miguel
