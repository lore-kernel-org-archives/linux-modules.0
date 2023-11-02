Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C763AA
	for <linux-modules@vger.kernel.org>; Thu,  2 Nov 2023 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QWN2P9Wc"
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D23912C
	for <linux-modules@vger.kernel.org>; Thu,  2 Nov 2023 00:21:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so964810a12.3
        for <linux-modules@vger.kernel.org>; Thu, 02 Nov 2023 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698909689; x=1699514489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZzgMxS87UstitPyGkyQS3FJndMdCvFkV+kwkI7K4+Q=;
        b=QWN2P9WcCB2Q6lZ/vwMwQBYv6uHkLyUpPD98yBV4y1iNNdFRkkPwFil7/3q6Kz59l3
         rxPz1w3uhvSloW05Qye82yBS6rx5DwS6jJ/i9fzzZTNPWA+nvmv1Hce6RU/mj+BmdZao
         H3E7hxyrWn1ydvf31LfF7KWQpJOV/7ALr8Txo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698909689; x=1699514489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZzgMxS87UstitPyGkyQS3FJndMdCvFkV+kwkI7K4+Q=;
        b=HoEeLflAqOetcVwyfE3J3JBmP6evLa76i7van0NJRhOv7F3hJZkOnQtdWZdpZhRlDG
         vN5thVec4vm8b3scJO8GDr3UM8e0hAM35hw+BDA7XZjgCa6i5hRQED/PwSdZIV27/VCB
         u843WHVGT9cujQ8qNOu/2ylXjN8WOoS5lqwavQKI2davTaLP4CX4RaRK60fAcIy/bue9
         cCnT02cPoOB4nZpr2v6Z7AX4D+08dNtZCrK0q2Liyke/mKNYpdvOeM0xM9gFOmg9CYOZ
         MeMwg2E9D1ghMm6r8c1XqfaIT9ip0KQcTkG3BcNmjjGcIawWeHxOrMlsiObaw5YgHQPw
         mQFg==
X-Gm-Message-State: AOJu0YzViVp6fcerkAxAf0z0wXLaPm3NVc/x43wQYFQ9nhR80Bt85+2e
	9w4kIgwFglVutyE2cEie6yAgMpFoPYtrvlSw2ehWGXTK
X-Google-Smtp-Source: AGHT+IFcZe5/KxVSOZSx7ri94pKdwej5fgl7Jg7ZOkhC64NVt990BOQOXAK4kvfafBoieT/v2PGcCw==
X-Received: by 2002:a05:6402:40c8:b0:53f:c889:8f89 with SMTP id z8-20020a05640240c800b0053fc8898f89mr17539387edb.36.1698909688906;
        Thu, 02 Nov 2023 00:21:28 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id w13-20020a056402268d00b0053da3a9847csm1948892edd.42.2023.11.02.00.21.27
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 00:21:27 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso86534466b.0
        for <linux-modules@vger.kernel.org>; Thu, 02 Nov 2023 00:21:27 -0700 (PDT)
X-Received: by 2002:a17:907:7ea4:b0:9be:8ead:54c7 with SMTP id
 qb36-20020a1709077ea400b009be8ead54c7mr3648207ejc.12.1698909686859; Thu, 02
 Nov 2023 00:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org> <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
In-Reply-To: <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Nov 2023 21:21:09 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi=goCaTm6ZOKzm_ztky9ZT-vuGDWv39vVdtQT+oW=zEg@mail.gmail.com>
Message-ID: <CAHk-=wi=goCaTm6ZOKzm_ztky9ZT-vuGDWv39vVdtQT+oW=zEg@mail.gmail.com>
Subject: Re: [GIT PULL] Modules changes for v6.7-rc1
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, andrea.righi@canonical.com, 
	keescook@chromium.org, zhumao001@208suo.com, yangtiezhu@loongson.cn, 
	ojeda@kernel.org
Content-Type: multipart/mixed; boundary="000000000000642f940609263c74"

--000000000000642f940609263c74
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Nov 2023 at 21:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> kmalloc() isn't just about "use physically contiguous allocations".
> It's also more memory-efficient, and a *lot* faster than vmalloc(),
> which has to play VM tricks.

I've pulled this, but I think you should do something like the
attached (UNTESTED!) patch.

                Linus

--000000000000642f940609263c74
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_loguy4k40>
X-Attachment-Id: f_loguy4k40

IGtlcm5lbC9tb2R1bGUvZGVjb21wcmVzcy5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvbW9k
dWxlL2RlY29tcHJlc3MuYyBiL2tlcm5lbC9tb2R1bGUvZGVjb21wcmVzcy5jCmluZGV4IDQxNTZk
NTliZTQ0MC4uNDc0ZTY4ZjBmMDYzIDEwMDY0NAotLS0gYS9rZXJuZWwvbW9kdWxlL2RlY29tcHJl
c3MuYworKysgYi9rZXJuZWwvbW9kdWxlL2RlY29tcHJlc3MuYwpAQCAtMTAwLDcgKzEwMCw3IEBA
IHN0YXRpYyBzc2l6ZV90IG1vZHVsZV9nemlwX2RlY29tcHJlc3Moc3RydWN0IGxvYWRfaW5mbyAq
aW5mbywKIAlzLm5leHRfaW4gPSBidWYgKyBnemlwX2hkcl9sZW47CiAJcy5hdmFpbF9pbiA9IHNp
emUgLSBnemlwX2hkcl9sZW47CiAKLQlzLndvcmtzcGFjZSA9IHZtYWxsb2MoemxpYl9pbmZsYXRl
X3dvcmtzcGFjZXNpemUoKSk7CisJcy53b3Jrc3BhY2UgPSBrdm1hbGxvYyh6bGliX2luZmxhdGVf
d29ya3NwYWNlc2l6ZSgpLCBHRlBfS0VSTkVMKTsKIAlpZiAoIXMud29ya3NwYWNlKQogCQlyZXR1
cm4gLUVOT01FTTsKIApAQCAtMTM4LDcgKzEzOCw3IEBAIHN0YXRpYyBzc2l6ZV90IG1vZHVsZV9n
emlwX2RlY29tcHJlc3Moc3RydWN0IGxvYWRfaW5mbyAqaW5mbywKIG91dF9pbmZsYXRlX2VuZDoK
IAl6bGliX2luZmxhdGVFbmQoJnMpOwogb3V0OgotCXZmcmVlKHMud29ya3NwYWNlKTsKKwlrdmZy
ZWUocy53b3Jrc3BhY2UpOwogCXJldHVybiByZXR2YWw7CiB9CiAjZWxpZiBkZWZpbmVkKENPTkZJ
R19NT0RVTEVfQ09NUFJFU1NfWFopCkBAIC0yNDEsNyArMjQxLDcgQEAgc3RhdGljIHNzaXplX3Qg
bW9kdWxlX3pzdGRfZGVjb21wcmVzcyhzdHJ1Y3QgbG9hZF9pbmZvICppbmZvLAogCX0KIAogCXdr
c3Bfc2l6ZSA9IHpzdGRfZHN0cmVhbV93b3Jrc3BhY2VfYm91bmQoaGVhZGVyLndpbmRvd1NpemUp
OwotCXdrc3AgPSB2bWFsbG9jKHdrc3Bfc2l6ZSk7CisJd2tzcCA9IGt2bWFsbG9jKHdrc3Bfc2l6
ZSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCF3a3NwKSB7CiAJCXJldHZhbCA9IC1FTk9NRU07CiAJCWdv
dG8gb3V0OwpAQCAtMjg0LDcgKzI4NCw3IEBAIHN0YXRpYyBzc2l6ZV90IG1vZHVsZV96c3RkX2Rl
Y29tcHJlc3Moc3RydWN0IGxvYWRfaW5mbyAqaW5mbywKIAlyZXR2YWwgPSBuZXdfc2l6ZTsKIAog
IG91dDoKLQl2ZnJlZSh3a3NwKTsKKwlrdmZyZWUod2tzcCk7CiAJcmV0dXJuIHJldHZhbDsKIH0K
ICNlbHNlCg==
--000000000000642f940609263c74--
