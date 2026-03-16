Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE938D6A9
	for <linux-modules@vger.kernel.org>; Mon, 16 Mar 2026 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658092; cv=none; b=JVI9ywy3cVpRrKxnJkbIKJB6suq9psDgndK9GmZYtHQDuAJfqqMPc0O/WZyMwgUZN3wm2azuq2o+tG9zk5N2btD9qiAqY89RbsuHmGSdgp0Tcu0/th2FufkuGZuN3mFO+2HG29jTTtNYWn2+1NhGPBPe2JuyAY4C11DxHxa8324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658092; c=relaxed/simple;
	bh=RvKLcKkFi38KdIwPbZcxye0llCWFTvcL/SQDV4UaCb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aqvg7fzZ0LpgqWV2SG1Ahxy8M0yLVj3grQ9KNFv3l3h0dwxaeZ/R2Hl3n4q08tURBWG2xEcPgf7Nx3xUHB2tD+JuLl9RPWfLgGLdMb5Bt+A1Y6tswcBJvVxyzTVTdAt98MrUv5gEbxwXhQLHRTBFVKdmxThorCxGxY4jfLQEg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gaj1RaG+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gaj1RaG+"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so39259715e9.2
        for <linux-modules@vger.kernel.org>; Mon, 16 Mar 2026 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773658089; x=1774262889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COAVljU9VJ7FLI0cTY3WOLojAyLOilMuqo6ThWcTiZA=;
        b=Gaj1RaG+WOoqtud/+UB/fubOZjPECaJ/7hVuIMW96A9o1G5f6Yq0/IfNVWFabxETpp
         2A01acbmpW4X0Wbuejy5TGLqshTXET9/arwqvO5Lcs5dt1KAxG/kImrQaj/EOckkL+Sw
         Wi/xXdmbD68B1R6n+UTinlvXonRmJyLI9Pj8z7XCxuOdPa3mLZrSEZ4wmCtVTgXtyfEl
         KyLnB+p3ydnfiNP41j1kYp7aE5TulW3dWso80oMpc+iYnxxUEBPJ2Ra1jhJ9LM31pYcO
         KCsNTFik5i1gieAUfDehCP7K0HA42p7lIfZ7Xtkv88epr97ObFXFQFvR+vUwkubocui9
         lAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658089; x=1774262889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COAVljU9VJ7FLI0cTY3WOLojAyLOilMuqo6ThWcTiZA=;
        b=Q5RFDf8nj2po7KhSfHaliY5nGcPtJZDPWEe5k0g8MRORsURkblXb6iZ8hFr+aWIe8X
         ROXO814KIGBieqA12aulaf2ceeG2G6cb1LckOn4xMK+oZvh3dWr8zigGzQwUwaaZPDQA
         dm/qCiWgx1PLh2enecbKJBLsw4Z5ZhH2ywYgTUyyBEZOE6xrrYTmVoFo4AyjwkR8c/6p
         PQF4AW03fVhG4XSiaCpZ/b3B9SU7gFSk6QfOoU/gdwW1VoK6jN7DDQMQ6QaJ3b3YcVq0
         Ycfxa1Idx94KsYIZ6pHS/s7PrwBWoTL9lZ1bpYlsW9HVDIrYYIitvOiXQ/CEAMJ6Vcj9
         wKQA==
X-Gm-Message-State: AOJu0YzN84FS0w6rFXsnOzcI3XiICO2F5x/IqiwhGe21fM5IWFE/GnZy
	FKePMkc0tAFLJk6kU48D7wJC8EpTSRkgaNs9fS2xvAJzSspwenAWatN9Mu4abCWf5YY=
X-Gm-Gg: ATEYQzzVZT+gN7VV+2bOiGdZHBbfdh8xrLDMv6kroIFucwJQwX6GCHzS/LLyDSdqdQc
	Puh7oKWU5pXpCjBIvS8Wf3jgICTpWnfwA+ujtR70/fQa2IZEZDe3KS8nuPZ1UdRRMb3u6xKuzMv
	ZVN1GA4LpabUl1nNbpV34Jy0NLlIYn5YXWqewP82WidM8FdQHX2R51L/OpgW8pqzGbQzI39DeQC
	yAcx7OT2X007kMpzErK6ZD2YQEKmEXPycTmGm2IRSnT9era8E1stZ60+tu7hmuOvLDg2JlgGs4s
	q0ESSouqu43ENrknwZM1mdlSxAlOTePqETJPrOPlHmI3Jo5Tbi2psCFzfX1yX9iefI4ujJKBwtn
	wjZWjcENkSwsw4VC7qGx25/TLleWByYOdhHBqTUIZr9ppGkPdedMHBM2gcS9esdouR0u5pMpZ3n
	XH59Y0IP0tmX2Pj+fPm1OkPI09P0bhVWc9VYXjgH4tuNd6
X-Received: by 2002:a05:600c:3b14:b0:485:3aa1:a7f0 with SMTP id 5b1f17b1804b1-485566cfbadmr214165865e9.4.1773658089472;
        Mon, 16 Mar 2026 03:48:09 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556395df4sm86533895e9.0.2026.03.16.03.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 03:48:09 -0700 (PDT)
Message-ID: <f037d2de-a88e-4f19-8545-b82ae10e7e75@suse.com>
Date: Mon, 16 Mar 2026 11:48:07 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: remove MODULE_VERSION()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Shyam Saini <shyamsaini@linux.microsoft.com>, Kees Cook <kees@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Christoph Hellwig <hch@infradead.org>
References: <2026031341-evolve-repeater-987b@gregkh>
 <2026031303-prelaunch-creation-3fce@gregkh>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2026031303-prelaunch-creation-3fce@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/26 4:46 PM, Greg Kroah-Hartman wrote:
> On Fri, Mar 13, 2026 at 03:20:42PM +0100, Greg Kroah-Hartman wrote:
>> Module "versions" do not make sense as the kernel is built all at once,
>> the "version" is the overall kernel version number, so modules can not
>> really be described as having a unique version given that they rely on
>> the infrastructure of the whole kernel.
>>
>> For now, just make this an "empty" define, to keep existing code
>> building properly as the tree is slowly purged of the use of this over
>> time.
>>
>> This macro will be removed entirely in the future when there are no
>> in-tree users.
>>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Petr Pavlu <petr.pavlu@suse.com>
>> Cc: Daniel Gomez <da.gomez@kernel.org>
>> Cc: Sami Tolvanen <samitolvanen@google.com>
>> Cc: Aaron Tomlin <atomlin@atomlin.com>
>> Cc: Shyam Saini <shyamsaini@linux.microsoft.com>
>> Cc: Kees Cook <kees@kernel.org>
>> Cc: Thorsten Blum <thorsten.blum@linux.dev>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  include/linux/module.h | 56 +++++++++---------------------------------
>>  kernel/params.c        | 30 ----------------------
>>  2 files changed, 11 insertions(+), 75 deletions(-)
> 
> 
> Sami just pointed out to me off-list that maybe I should also drop the
> srcversion stuff too.  I'll gladly do that too, does anyone know if
> anyone even uses that anymore?

Despite its name, I believe srcversion is primarily used to identify
binaries. Nowadays, modules contain build IDs, which is a standard
mechanism for this. The information is available already via
/sys/module/<module>/notes/.note.gnu.build-id, so removing the
srcversion data makes sense to me.

-- 
Thanks,
Petr
