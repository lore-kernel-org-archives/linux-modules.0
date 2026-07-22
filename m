Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863938887B
	for <linux-modules@vger.kernel.org>; Wed, 22 Jul 2026 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784711775; cv=none; b=LUEJhmfjBMW35+NsCPmT6W8HxhH52BdfWe57ufIJWEBTheV+97h9w1B4BpAjczcrhSp7cYdSFs2LarM2S2kgAWmFHShTnTg8qwiknfWhK/WcN3KHlSEcrdyH5DUzFEoLBYokcqbppcPR75OCB+tIQI0aGWcHG/rHN/XaYKBLoOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784711775; c=relaxed/simple;
	bh=WHTeaknv78De6KO44hwqgZ7aTIPj60igzBhp6OOHFoQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dn99T2pUAiRR1E6stDjnu8+lAwaMxeAKSIsO/Ro+yeg9tusu2K3XgG9yPv4T/TpPeR/fN+/OVslbae2pLldt1bo/Ejm0dihE7pj4ys6cZUuk9IiLrwIyh/bn/4K4W+jXa3kK/AVXk8JyGyoRKJSBor53YTOP4AHmqUgQ6EzeTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gR/kh9uF; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gR/kh9uF"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f24a50f0cso11343212f8f.3
        for <linux-modules@vger.kernel.org>; Wed, 22 Jul 2026 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784711772; x=1785316572; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XnwvnzL9yajO681ECkplP5nrBBFaUwXqggP7vnGCUwo=;
        b=gR/kh9uFrzVGOnsMjiFz6NxGibxNH5nF29WUTCuXnrFEy6oQ7xZUk8TK/vDzUXIW5N
         qAti8ky6yaGQjOZcDSpBsiKD2qFq/Rf9kM+557zroLvH1/1P6H47lMFpclqBQKHWG+JG
         uHZN14WD+/afkZMouRoXwnhfNWw0SuQMXwR7+NFChzR/t/2ba641LMQhTPJKmK1Rh6dD
         vadX1UK4uY1HrleuNSHOHyTK3y3Lnn0WQwefeFPS5YzZfJjMOhZjilupIyzJDGE9Ak7/
         FtZHA57yqEIpsPTpj/Bzxxd5I/pQM8EwXli2c6b9j+dTnXNeKbK0hVX9wy7Hv/Xyp4Dg
         dIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784711772; x=1785316572;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XnwvnzL9yajO681ECkplP5nrBBFaUwXqggP7vnGCUwo=;
        b=VSXg8sTCWu/4VaFq6LyRb4BgcqcGKioliF1k5upCbAmoxJpkRBotokdbwEMF+vIkIL
         zLfjdisrILTrK74XbBDgbvufC2ZQmFAYcqi9Fg7C4tK9C7oGGO2jkEMjGSIyTc6tPhlG
         FfrB/kk36kyk0qaHTcOau1f362j2uhNI9uE/M96klWq+251I742+AunXfZibekQQ1gkt
         IhZuwqWPGBK1DxSqfpUCJzSYVa9EXvjmPviH4y33SwXIuv0dC9jDDrI1SbNZi5kHcLsV
         yECrqG4KXDVDuxgaUNnd6yiDvcYhxaasjLY5nbZccMQM04xjOtFwy7AGZ4psLK1r+D3W
         +7QQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVM6hkSCwuU4JkFbWGoBDaURqkh8Lk/Gi4bE9QHeVyMdL95jCoU/F5PAB2CaJREKrpAUNBE2LgDxn56Dv0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Y6xNL51O0xBh44ZiLyAWlY1Oa5BkjcwXwwPRphl3uYYQMETd
	WrEYOpgvV3qbsWSFoPsJja+t0+H/FSybVhnAvV28gE81DmN0ekGBBioLgOBxl6Y8m5vtOFwhtTz
	QAjEfa7eJ47gq5fHVVQ==
X-Received: from wrnd1.prod.google.com ([2002:adf:e841:0:b0:46c:d068:1ef8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1882:b0:47f:5c33:5eb9 with SMTP id ffacd0b85a97d-47f6233c20amr25186040f8f.52.1784711771641;
 Wed, 22 Jul 2026 02:16:11 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:16:01 +0000
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFGKYGoC/x3MQQqAIBRF0a3IHyeog6K2Eg20XvUhVNQiiPaeN
 DyDex/KSIxMg3go4eLMwVfoRtC8W79B8lJNRplWdUbLjBL8DBlDPA9bIFdje9dqC6cXqllMWPn +l+P0vh9Z3b0eYgAAAA==
X-Change-Id: 20260721-setonce-populate-f2a9b61aeb1d
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=WHTeaknv78De6KO44hwqgZ7aTIPj60igzBhp6OOHFoQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBqYIpVERMIl8h/BGdn1orEWFHvlODd2hyo0IQJL
 38oV1M/+MqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCamCKVQAKCRAEWL7uWMY5
 RtZjEACqLldS6wAFVn6M3USar454sSGS44ygerOkuBV2Bv3lvTMOh8ezyzHqndQkpeQArGQ+FOQ
 qSLlZCsWZWtWQcZrShCXwmKUovT+g+6Ark+Un+VMlXWnbrTIl5IGPpHqrwSgYC972yzEJCx2GzS
 fuXn0vMsUza8QgcdiCQk5O4MJJRE7ag3FW2qc86JtDbBhvvJGOMK3U7NNuqPwxHtJWMkxkbtW4X
 qh19FcoHu2OpkkKz76cSHZ/WCK6JS/1+Iu6fTF05+rP6qi9u8LnDDFP8bb7c92IYJ9nogbukuy9
 ttRGb3TmHY0vsjf8DQsPp2RJ8KvqAGwO/ToCLiJKbnv4oifbMERi1fVyvFmT3+97AIlf4dOKTDj
 1e2BTsCvZ5oXHYQwmk6YoIXgtCrZ6QZpkLaiSBYHlXrGNtypWHJLqoqNCKd9FBXMcBcpPePMa8Q
 jjDJqKieCXNkBwtETm7c1XRBQDAEiRf3O65BGojyiCDIknV3OLyGEgwYHb/kUI88podGfQpqcnB
 8/xyewFxgbqgDsr57KN+JL7+3HKj0nNtsRn7wvxB5+YFfo0X1ayWXF8NYCbejk1SCCv8ttyp2LV
 Zp5bEyn9OmxrY1ib3WM/U/nb9OWHExj8mL11WXgnoP/HFxk4VT4L98xUBv6MDKCS9oJwUNAr3Kq LqMcPGpGzuZA5dA==
X-Mailer: b4 0.14.3
Message-ID: <20260722-setonce-populate-v1-0-fa7455c26c42@google.com>
Subject: [PATCH 0/3] rust: sync: add SetOnce::try_get_or_populate()
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Lyude Paul <lyude@redhat.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	"=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The SetOnce::populate() method does not internally synchronize callers
that fail to populate the value with the successful call. This means
that naive loops using as_ref() and populate() can lead to spinning on
the initialization, which is best avoided. Thus, provide a helper that
avoids this issue using a user-provided lock.

One potential alternative is to change populate() so that the failing
caller actually does synchronize with the successful call to populate().
However, this is somewhat tricky:

* There are users of SetOnce that construct it in const context, and we
  currently don't have the ability to do that for most locks, so we
  cannot easily add a lock to SetOnce.
* Just spinning on the atomic is undesirable unless we disable
  preemption in the success path. If we do disable preemption, then that
  raises complications for handling the PREEMPT_RT case.
* It also raises questions about deadlocks if populate() is called from
  irqs.

By using a user-provided lock, we do not have to worry about these
issues inside SetOnce.

This series is based on char-misc-next.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (3):
      rust: sync: return `Result<&T, T>` from `SetOnce::populate()`
      rust: sync: add SetOnce::try_get_or_populate()
      rust_binder: use SetOnce::try_get_or_populate()

 drivers/android/binder/process.rs | 16 +++--------
 rust/kernel/module_param.rs       |  8 +++---
 rust/kernel/sync/set_once.rs      | 58 ++++++++++++++++++++++++++++++++-------
 3 files changed, 56 insertions(+), 26 deletions(-)
---
base-commit: 2cedf2272f1bb42471e646868ac572cc5752bd91
change-id: 20260721-setonce-populate-f2a9b61aeb1d

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

