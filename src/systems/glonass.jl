# ==========================================================================================
# glonass time
# ==========================================================================================
"""
Generic function related to conversion to/from GLONASS Time reference.

# Relationship with UTC

Relationship between UTC and GLONASST is:
```
        <-----3 hours----->
      UTC              GLONASST
    15:56:23           18:56:41
```
where the difference between GLONASST and UTC is fixed to 3 hours at any time.

# More info
Check [Time References in GNSS](https://gssc.esa.int/navipedia/index.php/Time_References_in_GNSS)
for more info.
"""
function GLONASST end

"""
    GLONASST(t)

Create GnssTime from timestamp disseminated by GLONASST.

# Arguments
- `t::DateTime`: GLONASS Timestamp (UTC+3)
"""
function GLONASST(t::DateTime)
    return GnssTime(t - Hour(3))
end
