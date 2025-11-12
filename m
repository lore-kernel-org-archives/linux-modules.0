Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D75157A5A
	for <linux-modules@vger.kernel.org>; Wed, 12 Nov 2025 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955490; cv=none; b=aWTMiSbcrRzumh7czGtpibP+GODpPYWlanBFuEz7Xnf5Q8ugpZhCMIuTtNGEY/G5uqK2jdi41toF2nLIsmi96VtFrhxCt16IadSxFMKQawL7xUV6r1T2G5Z259KqbZXqNjmGLY3rF+Q6iDzvTrB1SOEtdhtl4rnTaCA6BGjlkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955490; c=relaxed/simple;
	bh=n3z9Jw7bEHMAgnOiDe5IhWMfzXL5QaG73RaPQ8hsiRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prss4knQf8l+F6mui1LUNbdm7eDv8lL6sefXpRTHaZKC2EW6OFcgmPtdZRHQogruDhM8Ch0925H8R81tZUED5xsSSPD5nLYTlMlg1HXdxJ9Pa5a9jw/M8v/tiLoSr0v72FHbUIQi71YhTer1Ka4xWQwdwht+pdvAlSRGvGstGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NhjKngH4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NhjKngH4"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7291af7190so139306566b.3
        for <linux-modules@vger.kernel.org>; Wed, 12 Nov 2025 05:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762955487; x=1763560287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eiNlO9W/s4a9ATMZ+5tC2gxgF5OkwPuLSe2qOti34o=;
        b=NhjKngH4QwqCocKpnN5eT4FBJ1deZrwJaqsRkjprC3UrH7Pm2iiJ8OuKw6oQOe4sA1
         Q3WByqVtQt7KVx75osmvuakFUVSR5vx+oqsMRfjW3q6jyEKmjQ34bEPT1UOX9mh/MPf9
         M5TXQoKN5A6l+HbxJ9us9XDK4Pr0B7MkYCRlewNkckKUnTE2GKBa1PYq3hsjRUanGkdP
         SVhhDtty4vlCPeqLM79OQM4qauB4zJJQmic/5w93FYrHF6ye7rtQ+gjMfxbTnTevS8NO
         nqUlGOhLMvXYqYYcAkJ3bJFQuOLsDKengXD6h5PVppnfhX203LclBqRHr9zvdapRyFar
         CGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955487; x=1763560287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eiNlO9W/s4a9ATMZ+5tC2gxgF5OkwPuLSe2qOti34o=;
        b=I5cXYt5YNznOGX2l1RFXmRGAdJVPLUvOgjsbYk7NHmZobiQOd1t55OG+ZY6ebvBnJD
         USL+IPqJ+LZ4tQq4uVJLHIZtzLfeaUiVJRHP7n5Fuuw2A79uYaP7ryzK2fU+MQz7YkMA
         ghg3j+BLnL6vbroLpT7icwEkWHefRV3s3WmW00qXmDHySnWgU6HmDZxzprh4kiEhnKbQ
         1zrZbY3wel0yuypsp3htWDaLZnSCU91Bi7uSFkp43aZQSO48M7bDWxmIs5OC9BsyjFT8
         P8kPsjKnXJpWUxlhXjUoE6z8zG9iyJnedayhWge1twT4w8/6TmNtN5aFdfY8LVKQxidg
         hqeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDXIGyboyNIicQ5CDw3vLanGoQg1n+fKFfvlp0aXzh1tbnZm48u1m0p1vN4mzc5sWFZw5Iwwom2BZFqrTj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1lXctJOkvM93HeV/r3uYx92Rm5Ru68p1hiCSMMkalMeWYpb+U
	PkkQdl3pHtN3KPogTi8LWx2NX/sWBTGFbf8zoROo9mSNqbIhs4mv4fw6+5oc3J7tcCQ=
X-Gm-Gg: ASbGncvfo5OlpeZGnu2FU2ols9n5f4xDdfFEQymxepNWi6qILqnRxopMT/ak6REYmAE
	2AgIZa0qDc7R8Cq5FkehAfDXYV+OlvbkkFQyF6CRkYrxxBXvcTzg/Lm7wdRwQ0ezSp4M91zhMzB
	c0MIfzQ2DiNpyTbc2OrzBpb1GdoAHUTHktlfXtNMSZFTFTxg8z8yhDk+SyyNlvW/ON5pOVJPESK
	irpMW6HbKKwQ9yN7TozfWb9tlL8I8hGrCwIn5QcYu36MYv0E5CJ2FpR8rPc1qewfvp/4JvseF+b
	0cTe5xHbYSu4VATne6cuyfhVFA17jrIuP9g2AgsCY3YrTQ+UUeXHEKDT375XnVFYMShWz2ymkTj
	jht02pUBPUWZO56Z4fC3MQINcGGJePoCXpZsLFAD0SqWvZ39PCbAF+xpkYtg34ksPNssljZPKFf
	bDsQhZACUR8m+cK20DwL6y4u7q2f5JOub/gUqomgDp4fj0PJ3a49/Pz7dvGNj2O884pMFDq4ZIv
	D13+DWSEI53t6+PriyF5u2wsjUzbzk4Iryvnr+b6RnON54=
X-Google-Smtp-Source: AGHT+IGh4KgZmhD9Tv0Q7r99njOC0g5Ef0gAEOLC9RYQ++zh2fc2FZ85E0tUpZs0DA8Ec4kM3FudQA==
X-Received: by 2002:a17:907:1c0a:b0:b39:57ab:ec18 with SMTP id a640c23a62f3a-b7331a9aa6fmr284237266b.45.1762955486563;
        Wed, 12 Nov 2025 05:51:26 -0800 (PST)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9be184sm1587077766b.56.2025.11.12.05.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 05:51:26 -0800 (PST)
Message-ID: <e624c242-b297-4bb7-a76a-cbb18b027472@suse.com>
Date: Wed, 12 Nov 2025 14:51:24 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sign-file: Remove support for signing with PKCS#7
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David Howells <dhowells@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, keyrings@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251111154923.978181-1-petr.pavlu@suse.com>
 <20251111154923.978181-3-petr.pavlu@suse.com>
 <922480ff44bda3b6ecfda1ae780c659644560f94.camel@HansenPartnership.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <922480ff44bda3b6ecfda1ae780c659644560f94.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 5:53 PM, James Bottomley wrote:
> On Tue, 2025-11-11 at 16:48 +0100, Petr Pavlu wrote:
>> The PKCS#7 code in sign-file allows for signing only with SHA-1.
>> Since SHA-1 support for module signing has been removed, drop PKCS#7
>> support in favor of using only CMS.
> 
> The change log is a bit alarmist.  CMS really *is* PKCS7 and most
> literature will refer to CMS as PKCS7.  What you're really deprecating
> is the use of the PKCS7_sign() API which can only produce SHA-1
> Signatures ... openssl is fully capable of producing any hash PKCS7
> signatures using a different PKCS7_... API set but the CMS_... API is
> newer.
> 
> The point being the module signature type is still set to PKEY_ID_PKCS7
> so it doesn't square with the commit log saying "drop PKCS#7 support".
> What you really mean is only use the openssl CMS_... API for producing
> PKCS7 signatures.

Ok, I plan to update the description to the following in v2:

sign-file: Use only the OpenSSL CMS API for signing

The USE_PKCS7 code in sign-file utilizes PKCS7_sign(), which allows signing
only with SHA-1. Since SHA-1 support for module signing has been removed,
drop the use of the OpenSSL PKCS7 API by the tool in favor of using only
the newer CMS API.

The use of the PKCS7 API is selected by the following:

 #if defined(LIBRESSL_VERSION_NUMBER) || \
 	OPENSSL_VERSION_NUMBER < 0x10000000L || \
 	defined(OPENSSL_NO_CMS)
 #define USE_PKCS7
 #endif

Looking at the individual ifdefs:

* LIBRESSL_VERSION_NUMBER: LibreSSL added the CMS API implementation from
  OpenSSL in 3.1.0, making the ifdef no longer relevant. This version was
  released on April 8, 2020.

* OPENSSL_VERSION_NUMBER < 0x10000000L: OpenSSL 1.0.0 was released on March
  29, 2010. Supporting earlier versions should no longer be necessary. The
  file Documentation/process/changes.rst already states that at least
  version 1.0.0 is required to build the kernel.

* OPENSSL_NO_CMS: OpenSSL can be configured with "no-cms" to disable CMS
  support. In this case, sign-file will no longer be usable. The CMS API
  support is now required.

In practice, since distributions now typically sign modules with SHA-2, for
which sign-file already required CMS API support, removing the USE_PKCS7
code shouldn't cause any issues.

-- 
Thanks,
Petr
