Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E4390600
	for <linux-modules@vger.kernel.org>; Tue,  9 Jun 2026 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000345; cv=none; b=gV38XZblTUmWRM4Wde+j1PCZAJYNDwyGg+wd5crxUMch4imf1CXhSw7CFbulTyZ42XXw921uBy+J5uGlg/rCtyxj/F6MKLB1gOlZKVfJ1QPxbsL0CcJ9wnid+hAELty+2pua3abGn+o7SxIvtWZOu0o1Bxk9hR7rHhbQYuRBhNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000345; c=relaxed/simple;
	bh=aTgcaHq96O96cNqr2TemkSTEHHUjgU/vx5s9EOQWy+A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YPHvXDwYmqTvLI2HfBmkE+BVeOAoQjPrN/3rdskeb9p0yzbjjaEzzjj+WTlBrSoQMRZ8sZolm9xQEYpKCrqR4znaVeuyHTcn8fmc1dNLRzevVptdqa8H+7WcdlmsPkbjJ9xg2Qog2GzNwEfIUu+Yt612DHxUEzV04yngCvLDX1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=JlveCJyQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="JlveCJyQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso44195905e9.1
        for <linux-modules@vger.kernel.org>; Tue, 09 Jun 2026 03:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1781000342; x=1781605142; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg//50A/gpUcIHuzGOz/tzazOMCNZ+P/7s0h3ZDZtUE=;
        b=JlveCJyQeT2XOP9y7mHyTVbTPrIosUmr0biBLrtHM7/HsELMMHXZw7tyuGTDjQqY+q
         A3RqtGgpYpGu/6wBqL+1D9nIgmzyY75IP2M5xLzXBHuO5ZZ8Bhppp0PIvIpQcJARGXUE
         MaOAUW7ediHD+xSPgk9r5Kd5IjD8kW/Fp21aKrItyrwlYkN40rHxq/odXAl+z+RMTgnw
         Jw3xlJIgnQC0m94bfWkzKUlBOY2fmtKyZvQRVkWakAsz7K2g1/99rrf4+FZtUJjaEHXr
         RrLgLfDytBaE2IrTzhumt5SIdDKsG3XcsaJKGLYC11tRQHoPT/w2kiRy/ifs9F6trqt3
         LVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000342; x=1781605142;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kg//50A/gpUcIHuzGOz/tzazOMCNZ+P/7s0h3ZDZtUE=;
        b=R1Pyqa9KLeTWAzmo40OlElEok9hblIMICqZaggDzgHkDURTK6v1g71AAbKXUWZASEW
         tGOceL9wX6b7WoBGLcpVoVeV2XQZC+2HAnWMfgKymzdt/6XA3/rEmYhkpr6eHX/JiXWg
         aqwSAbgWYBAw4L4B35J+6E6mi8Hm/cPQ0bGRKm+/Jfi7Xcu0qJFBkeqmugjE1zZ6Xkyf
         XqiMU8G3h4uDsfC3PaYv5eW2GKmUOMDn546hMfFCVR3jitjGj7NJzR/R3ZcdqYKnHT8/
         Cje6rfnRDPI/KHIKZ0pdSp7c+HkjgvPv9bXhrnC3LPNFaH06GnhxD60Ec7nN61U+qoSy
         YZ4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9unOlPwiOvFeYm+4wOQ/CogjhC3sFpSo6euXFIAQpmr0QAMBYFPZMg+zTEQFukNdArl50aokGVRn1fpdNN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+RaEq1xHo+V2Y99OjmrNM8tL6gNzysu4yowCE7C3Se3Z38c6n
	ykOxZQ3rxInvcabZurKROoODhDBvtB4A/CJonxt6Dn2+vm/byDHcBRKKfT2gGaB+zA==
X-Gm-Gg: Acq92OEFc8RQnEkMPPAB+7YTdfvP10SukogRxLPG3UNWROku/5KwlCvsw2BZ0GqPRtZ
	wsZKu00fNv6+fYZsyWpVndeOzRrC67C054Zk9PLdS3mIsCcLcDmrqFuj68T4Mf4nC58KD40KmbY
	Zg6W5UjAGaN4GCERrQZD2kg8k6/WGC2fj81O77fIBFXHFIBpcwWT945cf6RQ/mJ4DHiWg/Bqyry
	c4W/GIfBbffs8dGj2UAu+ehsK0+f9hR0U+2v4Vqk0Ilq5btKlCvnwr/+VrkxSWu7OEPWCW+AlR1
	JlRjDhH+cUr3/rug36rjuDtdEetHUD9gREXFXs8W1cC132dv+BJIT8AGe3OJ/wJhExyrCdnNubk
	m8U6y5ME9SXNbYFzbvWb0BFzm4o+avCx127XNIeRCbxFOO7zNRYB/AnmNS905hTKk7QO/13bPWD
	h1YofFS6iJ1wJyCTg0ToeEDCEsZgZ8OEINqWWTUEI=
X-Received: by 2002:a05:600c:8b68:b0:490:bad7:3634 with SMTP id 5b1f17b1804b1-490c25e1104mr335337855e9.19.1781000342117;
        Tue, 09 Jun 2026 03:19:02 -0700 (PDT)
Received: from localhost ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm455345945e9.7.2026.06.09.03.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 03:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 12:19:00 +0200
Message-Id: <DJ4FXHE7ZXQ8.1SGVBE57KSLDI@9elements.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Aaron
 Tomlin" <atomlin@atomlin.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 2/2] module: restrict autoload to CAP_SYS_ADMIN if
 CONFIG_MODULE_RESTRICT_AUTOLOAD
From: "Michal Gorlas" <michal.gorlas@9elements.com>
To: "Sami Tolvanen" <samitolvanen@google.com>
X-Mailer: aerc 0.21.0
References: <20260515-autoload_restrict-v1-0-40b7c03ddd04@9elements.com>
 <20260515-autoload_restrict-v1-2-40b7c03ddd04@9elements.com>
 <20260605183002.GB2939956@google.com>
In-Reply-To: <20260605183002.GB2939956@google.com>

On Fri Jun 5, 2026 at 8:30 PM CEST, Sami Tolvanen wrote:
> On Fri, May 15, 2026 at 07:20:20PM +0200, Michal Gorlas wrote:
>> Restrict module auto-loading to CAP_SYS_ADMIN if
>> CONFIG_MODULE_RESTRICT_AUTOLOAD is enabled, cmdline parameter
>> modrestrict=3Dtrue, or kernel.modrestrict=3D1 is set with sysctl.
>>=20
>> Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>
>> ---
>>  kernel/module/internal.h |  1 +
>>  kernel/module/kmod.c     |  5 +++++
>>  kernel/module/main.c     | 11 +++++++++++
>>  3 files changed, 17 insertions(+)
>>=20
>> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
>> index 061161cc79d9..496d8703f0c6 100644
>> --- a/kernel/module/internal.h
>> +++ b/kernel/module/internal.h
>> @@ -46,6 +46,7 @@ struct kernel_symbol {
>> =20
>>  extern struct mutex module_mutex;
>>  extern struct list_head modules;
>> +extern bool module_autoload_restrict;
>> =20
>>  extern const struct module_attribute *const modinfo_attrs[];
>>  extern const size_t modinfo_attrs_count;
>> diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
>> index a25dccdf7aa7..58b28c23f571 100644
>> --- a/kernel/module/kmod.c
>> +++ b/kernel/module/kmod.c
>> @@ -156,6 +156,11 @@ int __request_module(bool wait, const char *fmt, ..=
.)
>>  	if (ret)
>>  		return ret;
>> =20
>> +	if (module_autoload_restrict && !capable(CAP_SYS_ADMIN)) {
>> +		pr_alert("denied attempt to auto-load module %s\n", module_name);
>
> Is pr_alert appropriate here or can this be a warning? Also, use the _rat=
elimited
> variant like the pre-existing warning in this function.

pr_alert was here in the grsec version (thus I assumed it makes sense
here), but agree, pr_warn_ratelimited makes more sense.=20

Best,
Michal
