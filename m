Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011939;
	b=1xZ9JFNFm+A7yB/WRRoAoEkXO/t3yQHHy+SxcZzhH58UyPSwzELK5xUfyPwfd6+8yYUn
	 aT3usUcLNO8H6Plshb4pqp+mPTPsbRgJGPPm6TMXqHBWDnUtN6vm1TfJTVO165H52WvoI
	 IGSJpkHKkDBXT5nkX+AMfx10oeITfj6HnS9zAz70+LKezXIfIbzZpNnZBto+/uHkix4Y/
	 Zr1PvdbChAHh7NyHIuS62glGFX9sPbp5T41aSPudqVUR3+uDaZ/nKxiuJ6/FXv8lb8r6u
	 1Ev04vjjjN3x8f3qAlm5xb6Aqt/54bGlnOQn7XnEbLyc3nwekDBqvS4cAjlN0+ORe/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pJYLiDvG/cYZFF912St/REumGAtAgeyVkr7S9k0zDxU=;
	b=g+rTbQ0qmEyy4cmdyRbmaDvioo9JrNDMpyLYBCWuYZU0C6ZpN5wmi8N3pSxCbgCzbWlU
	 3I6+bQbY6AbnoBfP+x3KrwQly79K+VU6wk5K+2Z/cvSO4v4LVjs/cfXyr6AlWe//31dxm
	 V7wmezunpUgjjeDeLufEItvg4hYZArswdR9rvh7oDwXFAwe15QDOP0lNsJ/5b3WKGqcPT
	 4/e5CwS33nJ6+8I9iLXaqYIU/GMnCyL+yUu2U801QZu27jHC27AUFQUVi+M6/UERJeP9f
	 v5m9GsagW56QzKpkWmQVgj8cM03Pkxsn/EuDvDxjVZJskvsN+QmXfOuLqWtF8GU37SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YWsghDxz;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101060A260D
	for <linux-modules@vger.kernel.org>; Wed, 18 Nov 2026 14:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4101060A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YWsghDxz
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a34ffd3e39so542227f8f.0
        for <linux-modules@vger.kernel.org>; Wed, 18 Nov 2026 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795011933; x=1795616733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJYLiDvG/cYZFF912St/REumGAtAgeyVkr7S9k0zDxU=;
        b=YWsghDxzg2Lux99YESfzYQL//XPPR3c++qr0/GzYkcNYDro8cgiReMQckNPZDMaZe5
         Fy78fBYyrj8P3E5n6pISncJPDrlaVQQw6k6EIJ1Sn4S9s6l36LqQQbvArMcsZ1TjHBu5
         RpUftePyoNYJTIhyU4zqoooMUYzzmHrDdcpXXHxVGrRCTf3fuviCv4WsCNx2dyiK5lNs
         pCwxCkJOyZCg82FV5cx6diVUiJdkfmU4wXQh8mgSsYyxHtYznFrrQc7xY1KxEYtjKUnk
         N9srdBfTAJwd8igqqgJJF+w1xRbzs8Z09V/3XQxXp+Ntz+H0q13gocZMZXDsq1MEA6JO
         GLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795011933; x=1795616733;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJYLiDvG/cYZFF912St/REumGAtAgeyVkr7S9k0zDxU=;
        b=rKXol3tT0nwDSGVzanEi5TzPwyxhh5ax9CXnT+Ny63p6Wl6BRsS1FSG6P7tYfZFFFt
         4h/Fa0z0o34c/LvWA0DU4RV5MN8XJdnSS6e9KVg1PksctmDJeWVCS9mlf5TjtuTdwjsr
         rh6tbx4G2nBfMeXIaS1dkUkBqZF7X+VjgixnHKtqsWMypGLqIhQz/9P1ZCh0jz9XEY9L
         Ec4F75SOkbC2fpe3A+kdNZ38emoTV3PH8Jk0Q42IKTQzQ6QJ5gOGw0qjbxrcOP2hazbW
         qxn0maRrOMoULf5nA58spGfXXPH198ESBn1aFobEYFS369eCYOHGGJzc9WLlUymyLMG4
         RoIw==
X-Forwarded-Encrypted: i=1; AL+hErGTxYkSUyVwTcgZEcC+g2QMgW9pQc+URPDRkJ5AsekFmf5VhuG4Oup0QykaerO51hGnZUcEeyk3D3AE2nht@vger.kernel.org
X-Gm-Message-State: APuU4Z/TKOvk4yREHLDuhZNkjtoOVx/T/qcNCOd0evhJlx4Dtgt8AWbZ
	0Q226COWMZL2xfbaS6uHi/xaP5z/mvjRFvFGFjxSBBtua8BFrr4EQRPdwl7ysZ+/0Lw=
X-Gm-Gg: AZFdTZdyMyloMNrqIbxc6Q8u4GullcNdB0G1vvs0dyJUDtu+ZUCZshnwpFcd/5PyJ28
	vA2uSZnbX69F/5e/Gs+Mf0ih4l4mNCwQxyUnMIH8+T5VJVIBjyhAPuzn1LX6EG8BDqXQZymH3Lo
	RFAL0qB8kARz53OMZlDcGFtdkpG04dw1Ab5lwwCFB7JU8v64XYI8kefUj4JEyo6o59+pVOXLB0C
	BLzIqYQKb+S/np5bgGfmzQcyLRa1ESNOqmV01fKz/BwGS6Z3kosHFeV4bYpU6VXJEbto6n6Rvni
	Xp5ebc98t/Rx6YI6VSkS1E3h9kLbWzcu6yfvyv9ZoeatMMki9/yVasWZF+qw9unvG/4qupMGDsS
	DxkNRLLMw1fWB6MvaSqzC7XBi/g+0edpEKYN5F73dy4NqF0uotuAa6Y2c2nQJlljmMIQ/DveYso
	alNPeJnLTK0IcAmtCcoMgslE+xnrHALW+NK5geo5zchSdNklLBH+PuNcVIrQWcXXi3kA58Is2HQ
	v9fM8X3NoFmllPkMTNUJgm/OP4Z1xajWLf4UIb4V+1ENJMeG7AHKpUOE1LTQ+g0ifioyRpGJTwR
	oF/SQsffA3dDQWxdDKidlMDUyR/22nJV1EIFRE7L/qOJsbgaP5q+UpJMVhYhIpUWHA==
X-Received: by 2002:a05:6000:1a8d:b0:48e:d36:77 with SMTP id ffacd0b85a97d-4a633a63e82mr6580907f8f.4.1795011933441;
        Wed, 18 Nov 2026 06:25:33 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65541f3f7sm5346409f8f.24.2026.11.18.06.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 06:25:33 -0800 (PST)
Message-ID: <6f402ad7-8d8b-44aa-8333-0c647a9dc295@suse.com>
Date: Wed, 18 Nov 2026 15:25:32 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module/decompress: Use ssize_t for the zstd decompressed
 size
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>,
 Piotr Gorski <lucjan.lucjanov@gmail.com>, Stephen Boyd
 <swboyd@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261115145559.262878-1-pmenzel@molgen.mpg.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261115145559.262878-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/26 3:55 PM, Paul Menzel wrote:
> module_zstd_decompress() returns ssize_t, but keeps the decompressed
> size in the int retval. Output of 2 GiB or more becomes a negative
> value that is not an errno, and output of 4 GiB or more can also be
> truncated to a positive size smaller than the pages mapped to
> info->hdr. Declare retval as ssize_t like module_gzip_decompress() and
> module_xz_decompress() do, and print it with %zd.
> 
> The Sashiko AI review found the same bug in the proposed LZ4 decoder,
> which is modelled on the zstd decoder [1].
> 
> The x86_64 build boots in QEMU/KVM, and finit_module() with
> MODULE_INIT_COMPRESSED_FILE and module.sig_enforce=1 decompresses the
> 237 .ko.zst modules without error.
> 
> Fixes: 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
> Link: https://sashiko.dev/#/patchset/20261113144233.193782-1-pmenzel@molgen.mpg.de?part=1 [1]
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Looks ok to me. I've slightly simplified the commit description and
queued the patch on modules-next.

-- 
Thanks,
Petr
