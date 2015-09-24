MIME-Version: 1.0
In-Reply-To: <55FC5765.8020003@redhat.com>
References: <1442004956-3868-1-git-send-email-labbott@fedoraproject.org>
	<1442004956-3868-4-git-send-email-labbott@fedoraproject.org>
	<CAKi4VAKZRmiis6qD37OXZ5kxEXqy+rxVgYQrz=uVUSoY7ni_FQ@mail.gmail.com>
	<55FC5765.8020003@redhat.com>
Date: Wed, 23 Sep 2015 22:16:37 -0300
Message-ID: <CAKi4VA+8TNW1ypLoB0jmoj8g8gHvk2b3doh0mgPjVZX9NQUEmQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] depmod: Fix message printing before log_setup_kmod_log
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Laura Abbott <labbott@fedoraproject.org>, Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Sep 18, 2015 at 3:26 PM, Laura Abbott <labbott@redhat.com> wrote:
> On 09/12/2015 11:55 AM, Lucas De Marchi wrote:
>>
>> On Fri, Sep 11, 2015 at 5:55 PM, Laura Abbott <labbott@fedoraproject.org>
>> wrote:
>>>
>>>
>>> Until log_setup_kmod_log is called, the only messages that
>>> can be printed are the default level. Bump a few deprecated
>>> messages to ERR to ensure they get printed and drop some DBG
>>> prints that will never occur unless the compiled default is DBG.
>>> ---
>>>   tools/depmod.c | 10 ++++------
>>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/depmod.c b/tools/depmod.c
>>> index 2a08b6e..30f6191 100644
>>> --- a/tools/depmod.c
>>> +++ b/tools/depmod.c
>>> @@ -2455,10 +2455,10 @@ static int do_depmod(int argc, char *argv[])
>>>                  case 'r':
>>>                  case 'm':
>>>                          if (idx > 0)
>>> -                               WRN("Ignored deprecated option --%s\n",
>>> +                               ERR("Ignored deprecated option --%s\n",
>>>                                      cmdopts[idx].name);
>>>                          else
>>> -                               WRN("Ignored deprecated option -%c\n",
>>> c);
>>> +                               ERR("Ignored deprecated option -%c\n",
>>> c);
>>
>>
>> /me confused. The default priority for depmod is LOG_WARNING
>>
>
> Right but it isn't set until you call log_setup_kmod_log. Until then it
> uses the global default which is currently LOG_ERR so anything at a lower
> level before this call is mostly useless. Changing the global default in
> tools/log.c to LOG_WARN might be another option.

Yeah, you are right. I'd prefer to change the global default to
LOG_WARN for all tools.  This will only survive until each tool sets
its own log level.  The DBG can indeed be removed.

-- 
Lucas De Marchi
