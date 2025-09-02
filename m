Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AC1E47CA;
	Tue,  2 Sep 2025 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756778279; cv=none; b=FZnmOrEwwIn+ZZ33ZdT7sL7B6HR8SRrCO0VRDHZ1K85gJshMGawR75KVkOGJE6LpSi6wcXINXuIXHH4QlRvkyD1iTvWMVvv83245hi7Acteks8dXmc2bgT7zBicO4T5doi8y9e9sZHaN/xdNLEqc4fgbTez43pMJDciOz0gysgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756778279; c=relaxed/simple;
	bh=hFptR4pAOKUoZ+zf5b2Bsv9U66SkUKb4K2ya73WpZzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D5MNADfJLYD4E8DrqKIRjXk9/W94sXDGPh7zoTRoYTyidfhKllBTKH3DBhPr8x33ef30P4o4oq5lNcn8yati9HnZ7aa1n0fJEKSc6Y9HPuRQZfNlcaOI4g+2IYAmLPEkSB7ReL1dsbSF6VPV3Bs/99oc521x0KcdL0O9WSfEC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1y/xq7y; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1y/xq7y"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4cf40cd0d1so2904091a12.0;
        Mon, 01 Sep 2025 18:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756778277; x=1757383077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avDo6KU0iA7+aiI6dQjwTQX6BZCc6Uqem/bjRnXYrgI=;
        b=B1y/xq7ycV1GHrmDjeD+sgLPXG3TlMnotTHYbBWVPllPb724boTYpUki9kRKRQsvNV
         cTpjQahyjN6Km75F6RGGKptLtCwl8Yn8x557ZLrRgBcSkQCCl6j00s9znKTJq73XpsMR
         0A40xTj6NMIRNHhzRkW806nQJwjjcKFlIxNhG7Hwp+0af8pR3XIxD7DLHt7pprfYlMao
         OqcPuBx5e5lVtTtwWNhM9Xr2FInWfNrVtjtqmSQK+MB2NKywOF3JU2RydTA6uUGoEJPr
         mMUJM9u9imWMXizeotf4odGoLt7tXzZR5zbrbtw1COn5W2Zw7yZEt4tBRUfObE2MBsYR
         avZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756778277; x=1757383077;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avDo6KU0iA7+aiI6dQjwTQX6BZCc6Uqem/bjRnXYrgI=;
        b=QCkILCOgN88KmU55uyxBFCjTPvNW7BftIUA+Ihd0h+C3cauIcCsjYD3ciJEm5yyqOQ
         XXiQrF2GTN/JGXJ9nkwnhb7YujxFVta2/Fkg3hRc2xyMNiE8sE5tv4gotXQbwe/dryzZ
         ANOB3xwTe4eWUbHCM0AsE8Kpub4ZqaLW066F3fIKjT1VgYPj+sljYkg6XBCbKt+PdZVO
         B3ZVwUzEph5aR+NyTgTHMsSqevlr/j2qGbsYh9tvYTVtLOJkiK4HaOZ3vhj1D+yjT51+
         u0/DuKvn3NjR4/uA5g3bYVOP1dyd8cTAB1I2xh80ga2Xd3AOeDZ2a6YE10MnXUle/P6l
         6SaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVntirjMlRBZTGAHHcLwGHzKcDQW/E+lJNRqtU73Xvx+z9ZXAfvn2gjXbf9JtKipPtEcSOw57TvqUzYCCGhaQ==@vger.kernel.org, AJvYcCXyNpcSYRcOZU0erCefEaXRE4LDJxLYTB05z4dqhYYhnVQzUAW0ilNU5n+iD0C+3FY2K9NoXjoWuZVZKFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3acTthHZoOyMgW2NYOupLTk26iuwDJfCfDOhb8ntaJ9N3aD9f
	KiMv/2r3Z50I53QnwTueycUfCqQYWX2Xei7m2FjU/8uImWX89WVeEF9i
X-Gm-Gg: ASbGncteUI3cuFU7r2fTe6+9YqyJLb8vLUVr7s6MDY46YOaSYcnjnsxwVIqkFXvVog4
	luIhZ7mCaIer96xf5CgJXqdiVcHGoXrfRnRKChpJLkBPYHG6bklX6HaR6kM94Ucpks/9ZyngAmA
	HO740Td8ObzyV3j9ooi1y//EAPTL0VzqQ9v3g1jTP3YlwBNFOBwBSGmkMQl15VPJYtAUPuE6s+v
	xSSEQDLradV5WB7mNV1ZeizFLDR222W44ugyrKxMOdPyJ7YUqS8gVcVJy9XG/+SdMxzVnotb/eo
	fhlSEIH7I2BkMfzO6yUc+hH8e0xt+eSsuJuGHDVPki876ZjUbT2FF+vMpBaLiXrjRs7MQ4Pl0q0
	qreieLqUto8VMaNUpwDtvS2PFSRzhiMxsyM2qH76MJ47J4QI=
X-Google-Smtp-Source: AGHT+IFV9zFpo+oFKE4pRtRbiGiHhUUtgVW81OrSDfEsB3NWqGPq8areA5aXaKuOP3FBM2TBXZMOFQ==
X-Received: by 2002:a05:6a20:a125:b0:243:cc87:f285 with SMTP id adf61e73a8af0-243d6f3dce0mr13551865637.42.1756778277408;
        Mon, 01 Sep 2025 18:57:57 -0700 (PDT)
Received: from [127.0.0.1] ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1cc2sm11731821b3a.70.2025.09.01.18.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 18:57:56 -0700 (PDT)
Message-ID: <80cee152-a9b0-431c-bfe4-333c28f83c02@gmail.com>
Date: Tue, 2 Sep 2025 09:57:52 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] module: signing: Use pr_err for signature
 rejection
Content-Language: en-US
To: Daniel Gomez <da.gomez@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
 <20250829084927.156676-2-wangjinchao600@gmail.com>
 <156fa755-6937-4df1-b995-99a2cc4bbb0a@kernel.org>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <156fa755-6937-4df1-b995-99a2cc4bbb0a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 02:18, Daniel Gomez wrote:
> On 29/08/2025 10.49, Jinchao Wang wrote:
>> Make module signature rejection messages more visible by using pr_err
>> instead of pr_notice.
> 
> Can you elaborate a bit more? Why is this needed?
> 
> IMO, I don't think making it more visible is enough rational to increase the
> level.

Thank you for the feedback.

When using dmesg, pr_err is displayed in red, pr_warn in yellow, and
pr_notice/pr_info in the default color. This makes pr_err more visible
to users.

In the kernel tree, there are around 4161 pr_err calls across 20000
files, compared to 276 pr_notice calls across 827 files. From reviewing
them, pr_notice is typically used in default or informational branches,
while pr_err is mostly used in error paths.

Since this rejection path returns -EKEYREJECTED and prevents the
operation from proceeding, it aligns more closely with other uses of
pr_err than with pr_notice. For these reasons, I believe pr_err is the
appropriate choice here.

-- 
Best regards,
Jinchao
