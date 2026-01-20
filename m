Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE673ECBC8
	for <linux-modules@vger.kernel.org>; Tue, 20 Jan 2026 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911522; cv=none; b=c6gRSmL8HNbTK48SFQFFiKAYeR2NvS8mo9XSV6OqkZOLnZdnxccOILPmxSDYfUHJ/HrSk3CWmx3kdbg1QFj2WpXaM0jIFrg1pHRbtW9UfGXmJ2rnE5eeefyTiqajl8XdMjh6fl51ftR2yoBZBQ6nnAMr2lY/qyY1RC0oC1H+/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911522; c=relaxed/simple;
	bh=yGS0ZhV/HmECUguQyiOv2PcpOrExvW9AuC6J9fOS0CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nncbfw+IKMQSCh8Woy4Z5bkzeh9QUjd1NDdMRZbd6t6itI3Lj5mIL/CShUfx2K+b4/dDPz/0972Y3X8PgoLHID6vIVUCVtTo0/jnUF6nMYDFE3pzvRNdYi5S1ePtwX1aVoe9BX7N125ReFgmvlV/GPYGnFi6afRbLWWZiKxld3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TxXPm3SX; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TxXPm3SX"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso18778735e9.2
        for <linux-modules@vger.kernel.org>; Tue, 20 Jan 2026 04:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768911519; x=1769516319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s1QLxkpeIxpFrMstTs2QBaunDmwUVDSpnYCC8/tZjnk=;
        b=TxXPm3SXzYXEWMyPWwXJiE31IPvj/QAgzjMskSNjekWpIy8sah4x6dvWZzlGpMvHsV
         Pox7nQBpHWJuXZuF11o4Ox9fIXdsJNPC9rZI5yD1kdfwdLgwWw8bMHFs5OYVhbuvxm4H
         rCGYf9nNMyNXX+C/pgJxPTbVwsjf873WS0HiF1eiDfJWhfWyZIDbRsQN+YQWTvg9epgM
         UHucV0hmPFBL40hItqhVW8m9sXCFsV4LGTudxesOaYwQ/jNAVRCrBF8L40es0f+mF46q
         dfeWBae3RNbHrcqFTrw+kcgdspJ3c284/J72VorVubEnC5EVQD9qm1YzI63FuQrrdKsP
         Ubzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768911519; x=1769516319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1QLxkpeIxpFrMstTs2QBaunDmwUVDSpnYCC8/tZjnk=;
        b=l0NUM8To1/txIPuhkJGAkvd1yedrnTqFlzNRaR6tQelPOxVjmxLH/g/Q3aXVviwkMY
         7GLwwOe2P38sN5XIKv0syzUWCiRBOud1MSC6qII4gwsSpgpMg6toBGhO0isCJvYNtB8Q
         e755OhtlcVHbMYJlxAqP6iqB6b4eoAYwf7FBr+27q8ieAeGrHzfVlHUC3R9IEiX3HeW6
         fchA94CUXox4aM7L03VyDQ2iH31WZdjP2PKHiGjRN9wK882xMyTPo+eCQ7JYSO/Kb0aO
         nCbWBZf70Zg49vRTh/E4LdXzH7npXjpR5jSQu5C+A2W4aTVZMJkILXj9plqaXhN4AKIj
         XLcw==
X-Forwarded-Encrypted: i=1; AJvYcCWA2/N554Koaoj1qO7/xOUZ12g52Kf+GihUzW0d9dhJ1+mFAVbQXsfkiJmrI9r3sOco/musRRRI4+g04c3P@vger.kernel.org
X-Gm-Message-State: AOJu0YyQYlWcqPCRqhAIMGsLsMjFLFHywAmwUoZwhEHxPMD5igGEbVKQ
	OrfrPkHDKdOBUd4SVPHcLOit37MIU7ZBBMlcisjZGAx5rp5J67qJGRFgjThVbVi2SIU=
X-Gm-Gg: AY/fxX4WjTYNXciITTSR23KPN1tGpQzroV7Pt1dWQvhlsgRiHm+71arcYHN4uek3Tmz
	tTYK8hpRczQOmGvZMwZBtNb4oBJxv+9HXtpWoE/IrhruggeRjNK0fBJg8hLDMCx5il09CzVW4N7
	GuE0A72ENByC1Wq1eaEMTNudC6soEv7OFaSVbvSZjNl5lGU/AsGZutSJwxeJ3jPMNRD/5gDjLPa
	AfVfgW32b8WKKgIdLMF/6JHYkSV4v6dOnPs3U05tg8pw170KuGWTr5QHq3YBgNvZFGggf91uBym
	AB+dIOn6tYfdGMHv00EV5/1h5oXZHEs2TakrNqCAdNn1MPFBVUtMa2yreraaPycUJBo38e1+Yn8
	Jak/1kpgB/J8bDdL3nrdczum/Aw3/s5S7qqrS1FXHka9ADxb6Fb3bhQrmZsj2kPfsfQSOgOk00G
	PKs6XYkiRbzTMfM2pf/MWgbUMpYfbhsQ==
X-Received: by 2002:a05:600d:6413:10b0:480:3a72:5c10 with SMTP id 5b1f17b1804b1-4803a725caemr54816275e9.16.1768911519124;
        Tue, 20 Jan 2026 04:18:39 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4289b7aasm306330525e9.2.2026.01.20.04.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 04:18:38 -0800 (PST)
Message-ID: <f1128fe0-96bf-4819-9315-dcd4a7dda2c6@suse.com>
Date: Tue, 20 Jan 2026 13:18:38 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Documentation/kbuild: gendwarfksyms: Style cleanup
To: linjh22s@gmail.com
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Sami Tolvanen <samitolvanen@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260114-documents_gendwarfksyms-v2-0-297c98bd62c6@gmail.com>
 <20260114-documents_gendwarfksyms-v2-2-297c98bd62c6@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260114-documents_gendwarfksyms-v2-2-297c98bd62c6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 12:47 PM, Jihan LIN via B4 Relay wrote:
> From: Jihan LIN <linjh22s@gmail.com>
> 
> The indentation in gendwarfksyms.rst currently uses a mix of tabs and
> spaces.
> Convert all indentation to tabs, and match the usage output and code
> examples with theirs references.
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Jihan LIN <linjh22s@gmail.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
