Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F8A3B47F7
	for <linux-modules@vger.kernel.org>; Thu, 20 Aug 2026 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219623; cv=none; b=aQ7kN/89J15h5PGXoUgGLGLgGD5b3Ty/EVDQGH/MP8IbJ3hKyp1Iytkmdrw+q1nFPu/Ga1F0/0GBNppk3iCkNnuuLcu1BVazM4CVPb0bUwe4FpSZlHPB7axUiDc/tDG75NZ3cvrNcJ21ZjiibBlT/EnYsZNybXXAB2L6p1N0X5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219623; c=relaxed/simple;
	bh=ej6Va93k+afyPpSdoRsXCwDTyq75PwwJMrXamE+Nyss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6K+7XPhrNzMAULqjmtawY7gNIzjroAjisPHNP8cLzFoIHxRA6oDtEAP3hGt+T8P0DGGa1TNuRx5Tj3uIyV8yWFJxM6E/2Ar5/9f8W/c+AAP5wwFbn4TbJGgFp2iLA4ld6ejsK+WV5zQf8Vcor1OBt2lgx/dH4f15QzPkxHDNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P7/uGkaP; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P7/uGkaP"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49954b88fffso20564325e9.0
        for <linux-modules@vger.kernel.org>; Thu, 20 Aug 2026 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787219619; x=1787824419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wP66327MWS8VhJp48Lj+aYSlLX7zAuS97DNshIbvPkQ=;
        b=P7/uGkaPjknwWrwLjK3CxqeXQ+TVHgTpJHbRiy8F1NbE0oki3O7i2TYGL5vVTkz5kA
         PsP9HewT9qI4nLR1njQhK3A1yBE48bLX2Gv/UwL1YbOxMEQvibhDDnW91A0bTzuAXeWo
         ilf8qH/0zcqk4bFnts9jReA+yMa2tYtYYJv1nXeyhXO89A1+FWeE34JWKaDL6q+KqOYw
         a5espBAMOnBZ1Dt1D0wN0l4IbO2RL96R2/KplU/OsIwU4XwF8WnSKi9hvkB2uCtGj/Ej
         CITUILogs15pmhGH5j/Ol2W2xfA/AJ0Us2I965Ci4o11AExqgRMA8UI8+rCfLVdX12Y6
         XkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219619; x=1787824419;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wP66327MWS8VhJp48Lj+aYSlLX7zAuS97DNshIbvPkQ=;
        b=bnpfHdpel2QJQfEJSWR3Qyz0BtBKdBGvUDovfpEDSPl7WP0vHJozMGbdYWk9gXUxtN
         C/FnstYlnT7E7P7zHg7/MX9O/EGBbpFn0ebCbO7JXpUb9olzHzL0DFbl9iKWbIF8fmWO
         kxCJqm/VeNl8TXkklqmy/ZARX/ZWRwm/w16n/+fSzF8CCWe0VW3/sejyLNIVsiZKBMd0
         ceDAffz8w75K8zEH9lk5R7VRCp0DZlp2q8XboRwFuvsSvggziYg9OCPAbNRtpKrI6xlr
         mGJV6CNjsCnampeZ14DBKJFZWYy9DAY000SG0FaU3e6nybXL5V1xXeGNOzK4ArlrFT8Q
         EGCQ==
X-Forwarded-Encrypted: i=1; AHgh+RopEVjae/VTKaOD0fed7KtbCaGVDEnsVy8VPPrTWQGMzECRLX6SiJiWVCKs3stV2eeYvaKtaDVfgWU+MQk+@vger.kernel.org
X-Gm-Message-State: AOJu0YywitPjrr1N5dBpOckB74qKZ4OjJ8To+5TWF8mjwU1unDpyhYuT
	lPRHUJO3+rmz3xZGV5qmOn+dvx5TVqzMnZ6vQpkvOhN31Qda576cBktRi1INlh37R9U=
X-Gm-Gg: AR+sD10uJRRpKEImj9RH7y4+lvPz6QhExKCCusDpWk6DmsOjOTRCCBQXhKAfhQ9pH+R
	/TpUG20j6DdziSQYmenvWzeUICsmpenhlbKMrRnIqh2/ypXPFQlVTFyYQE5v4bY0ffhNmrWqhL+
	yR0OZw+bcqnSWPnW40IRQcomv3ioepOxPkfRVL8CfXwEGwBNdk5PncAUuJSi/ET9CWqp9mIoll7
	7rJFe/WfWxb/ffdyE0VnBPa8OsoYu+Y+bqzkJvud7e09ob5t1TePE+veJFTVkseE5ovrB8dfdV8
	l5y1NMaQKI8CPKwllnqE2XAOmw+SlBhL1hZw9J09eJzRFFTQRbvZ6M/rgZpLmNnY8mzJ8HLhzlk
	4GukXu5hX1kKjnj8fgJeZ0nx0qmCjDWLROzvGR4PSclzRS9UXk10OIQkNp9hGOoF9FR7jzDZaML
	6cljHYIpE/xzBD/w6Ht6PQsvsbN3lrEPQQIoHhlH/XmzrAXoBWUl4gIKgjbJk9IWTPAZU0z78Lt
	ahfsAxgFkJKV+fp/YXOGkQA2h/ovHS+gNc=
X-Received: by 2002:a05:600c:6211:b0:499:a760:722f with SMTP id 5b1f17b1804b1-499aa1ba0b7mr207185505e9.13.1787219619110;
        Thu, 20 Aug 2026 02:53:39 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b20bb2b4sm33083495e9.0.2026.08.20.02.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 02:53:38 -0700 (PDT)
Message-ID: <226fd868-b51d-4ec4-b13f-520ccd0e8e36@suse.com>
Date: Thu, 20 Aug 2026 11:53:37 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] module/kallsyms: Rename is_mapping_symbol() to
 is_local_mapping_symbol()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260812032807.15034-1-yangtiezhu@loongson.cn>
 <20260812032807.15034-2-yangtiezhu@loongson.cn>
 <96b0e23b-165d-4026-bdfe-f8cd8ceb36ba@suse.com>
 <d22a5f25-b4b3-faa4-46d5-132f3fa725f3@loongson.cn>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <d22a5f25-b4b3-faa4-46d5-132f3fa725f3@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/18/26 3:04 PM, Tiezhu Yang wrote:
> On 2026/8/18 下午7:56, Petr Pavlu wrote:
>> Another comment-only reference to is_mapping_symbol() that should be
>> updated is in tools/perf/util/symbol.h.
> 
> There may be conflicts between modules-next and perf-tools-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/log/tools/perf/util/symbol.h?h=modules-next
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/tools/perf/util/symbol.h?h=perf-tools-next
> 
> So one way is to not modify tools/perf/util/symbol.h if based
> on modules-next at this time, the other way is to rebase the
> code and then send the series after the merge window.
> 
> Please let me know what is the proper way.

I don't immediately see that updating the comment in
tools/perf/util/symbol.h would cause a conflict with either modules-next
or perf-tools-next.

I think you can even base the series on mainline. It applies cleanly
to v7.2. If there happens to be a conflict, it should be minor and I can
deal with it.

Importantly, please Cc the maintainers of the updated non-module files
(scripts/faddr2line, scripts/mod/modpost.h, tools/perf/util/symbol.h) in
the next version of this patch so they are aware of the change.

-- 
Thanks,
Petr
