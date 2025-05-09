Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5AA235047
	for <linux-modules@vger.kernel.org>; Fri,  9 May 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803400; cv=none; b=DKzLLwx9h5scaM9gl76CySkdMS0PRIof8nekC1HOm1LwIvvNZoe6DKV3cRLFis2h6D4F/Y72svxfe7q5HsHum+mCGOcDN6lV+Yl/2uKXZKhyeamo9Cy31u1/vEELHBcbymEEwt8iINKtXfTEXIngyAmyil9UGZVvLhhbbQxDZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803400; c=relaxed/simple;
	bh=0raLsyvmspZO8KIh4Qq2YkCiCP1OpO5e3/Ms4xo0uMU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=N2TIKzTJrwl3bCnuyklS15eYSTj9ycUJ7MKzfpPZiYpzsdHti1/9APXYOXLC5ggtilbIreNQ8RxifMhJ9NBlDzqJPCxb513Ua4A2d9AoXZWLqHcvn0ZYL81505ebvdcayNlJXffhvmzsCIYG/GULolFU0m6QTeqzPQPUjKU73LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M20AqgXm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M20AqgXm"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so414811266b.2
        for <linux-modules@vger.kernel.org>; Fri, 09 May 2025 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746803396; x=1747408196; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtXiKhyTTbKRLQNr8fessPI0nm/AMjfgZ5fWE4GnCgU=;
        b=M20AqgXmsAmCMBOJZvtASPR3Q8vdVZbJ8FJNp7m/ICFs3oQhgRrR330u1nBoRXsJd6
         VExP9Slac3NC4E1MOWhPDb82G3dyQnKi2YF0yiWMcfw8bI7rBXAPc2t1OrLrocsOEaCN
         KRFJVSBvJsNzIstgH4RETK6K79GyiZTPfcqkeu1Ns0Wp9IIjxG26s85ZOJhBlav91n7Z
         BPl9tf3NOHE7/FOL70kmPjGj6NHltgQBH5U5lh7t5bbQtZ0Ez0ntPlwZV2Kb5YifBh7S
         N91nFHwHX3naykn0fUIDSG5+ucvjst1Wo0HxsC5lxJ7skeXL+vdH3SvYtv0rYYZ3QQ1w
         ZHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746803396; x=1747408196;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WtXiKhyTTbKRLQNr8fessPI0nm/AMjfgZ5fWE4GnCgU=;
        b=JShvUnly/Dw2NIblkTF2Vjozx5z5kuilImJfuMsm2abOwuTakjo5l/n31ZsfsIgDdo
         hDn3KZQyMnWT5kdvLX7db0E2BLwFAr8GcJqZ1iTI4Gu8KVJpBU2NllnUzxc01ngpmhwv
         HVfigj/m+XZiwJKeT5j7JNsbYU1Q8Pdkjdzx6ztuF2msvq8SUVrcDQJ9RVfewngs4PQH
         SMA+EcW/BArqmOd950qXU/dAdDwhtoHDL0i6bk/OjdWzD7SSbP0ebEDke2ddpIQAR6rG
         ilV6hWSwCo0giuaQeNC9+Tux6zge7sDfedJyOnR7+s44CnSsSska6VBGdkoTAJKQflH3
         H+3g==
X-Forwarded-Encrypted: i=1; AJvYcCVjYhymUGvg78OjYbHkjBfYxMg7/703+Gq6unAEE4kyfE3BjUIC9bNcRivMDOi0qqJBg1imP3aPcxiBnnSX@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/Cr46GSLgTQtiIoX8AKmmj0LumlATBAvU83peWhoDi5Dc0cJ
	HaYxBZj51t9CKIBcYxcUy3A+5syfVYicU2FQH9s7/Dyj8ik8P6zkUbASVpZIwQg=
X-Gm-Gg: ASbGncs+1ShZVEC5lonePQLTXSulvWzy2wwoCOOSWnpAvH3MHBZlPA63B6CSI9zUFR7
	BmRIPfYlMaWbNlETWdtESTBFdhwsMiz+4n5ZNsO1cMVW08aY1qRAJWXhCSgpP4kC2K+5Ml0mWd3
	4rkYbubOqUCz7wA5KCaXrlDwU3fAqoRIKk2/057YS0mlDud0Y/jje9kiMMmvQTbzIbBhOWuCIaH
	eOaOnNE828MG+FHlGVwfHufRw5KzkQyJ6gG6aYp9IxVN3ZIcvPHYD9Vlz7i7IhC5oBxMk+5jNie
	LkSTxHA3/zVda4CKVv+WU27c0FyAzzSM3QGjjzSVB3w=
X-Google-Smtp-Source: AGHT+IHcnFBxME8/PbbpkOaUefPkHynw9shIy4X2lxZw57yC0g7k6KUCMMkKDMKsDoJWYa7NGmZS7Q==
X-Received: by 2002:a17:906:c102:b0:ad0:688e:57d5 with SMTP id a640c23a62f3a-ad21917102cmr352225766b.44.1746803396346;
        Fri, 09 May 2025 08:09:56 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2192d4a1dsm165870666b.17.2025.05.09.08.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 08:09:55 -0700 (PDT)
Message-ID: <0e82be0f-a305-4aba-b9ab-79596f595277@suse.com>
Date: Fri, 9 May 2025 17:09:54 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
From: Petr Pavlu <petr.pavlu@suse.com>
Subject: [GIT PULL] Modules fixes for v6.15-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The following changes since commit 92a09c47464d040866cf2b4cd052bc60555185fb:

  Linux 6.15-rc5 (2025-05-04 13:55:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.15-rc6

for you to fetch changes up to a6aeb739974ec73e5217c75a7c008a688d3d5cf1:

  module: ensure that kobject_put() is safe for module type kobjects (2025-05-07 20:24:59 +0200)

----------------------------------------------------------------
Modules fixes for v6.15-rc6

A single fix to prevent use of an uninitialized completion pointer when
releasing a module_kobject in specific situations.

This addresses a latent bug exposed by commit f95bbfe18512 ("drivers: base:
handle module_kobject creation"), which was merged in 6.15-rc5. The fix has
been on modules-next only since yesterday but should be safe.

----------------------------------------------------------------
Dmitry Antipov (1):
      module: ensure that kobject_put() is safe for module type kobjects

 kernel/params.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
